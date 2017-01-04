//
//  MenuTransitionManager.swift
//  Project 16 - SlideMenu
//
//  Created by SHUN on 1/3/17.
//  Copyright © 2017 q2650108. All rights reserved.
//
import UIKit
import Foundation

@objc protocol MenuTransitionManagerDelegate {
    
    func dismiss()
    
}


class MenuTransitionManager: NSObject {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private let _duration = 0.5
    
    private var _isPresenting = false
    
    private var _snapshot : UIView? {
        
        didSet {
            if let _delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action: #selector(MenuTransitionManagerDelegate.dismiss))
                _snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
        
    }
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    weak var delegate : MenuTransitionManagerDelegate?
    
    var duration : Double {
        get {
            return _duration
        }
    }
    
    var isPresenting : Bool {
        get {
            return _isPresenting
        }
        set{
            _isPresenting = newValue
        }
    }
    
    var  snapshot : UIView? {
        get {
            return _snapshot
        }
        set{
            _snapshot = newValue
        }
    }
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
}

//==============================//
// MARK:      UIViewController AnimatedTransitioning
//=============================//
extension MenuTransitionManager :  UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /// Content
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        /// Menu
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
        let moveUp = CGAffineTransform(translationX: 0, y: -50)
        
        if isPresenting {
            toView.transform = moveUp
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        UIView.animate(withDuration: duration , delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                /// 把 transform 属性设置为 CGAffineTransform.identity 来还原视图，无需记录初值。
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapshot?.transform = CGAffineTransform.identity
                fromView.transform = moveUp
            }
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
        
    }
    
}


//==============================//
// MARK:      UIViewController TransitioningDelegate
//=============================//
extension MenuTransitionManager : UIViewControllerTransitioningDelegate{
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    
}
