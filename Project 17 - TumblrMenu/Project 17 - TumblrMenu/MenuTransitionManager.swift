//
//  MenuTransitionManager.swift
//  Project 17 - TumblrMenu
//
//  Created by SHUN on 1/5/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation


import UIKit

class MenuTransitionManager: NSObject {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var _presenting = false
    
    private let _duration = 0.5
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    var presenting : Bool {
        get{
            return _presenting
        }
        set{
            _presenting = newValue
        }
    }
    
    var duration : Double{
        get {
            return 0.5
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
    
    
    
    func offstage(amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuController(menuViewController: MenuVC) {
        
        menuViewController.view.alpha = 0
        
        let longRowOffset  : CGFloat = 300
        let middleRowOffset : CGFloat = 150
        let shortRowOffset  : CGFloat = 50
        
        /// Left Part offstage
        menuViewController.imageViewIdea.transform = self.offstage(amount: -longRowOffset)
        
        menuViewController.imageViewPlayer.transform = self.offstage(amount:-middleRowOffset)
        
        menuViewController.imageViewStar.transform = self.offstage(amount:-shortRowOffset)
        
        /// Right Part offstage
        menuViewController.imageViewLike.transform = self.offstage(amount:longRowOffset)
        
        menuViewController.imageViewPlaceholder.transform = self.offstage(amount:middleRowOffset)
        
        menuViewController.imageViewUser.transform = self.offstage(amount:shortRowOffset)
        
    }
    
    func onStageMenuController(menuViewController: MenuVC) {
        
        
        menuViewController.view.alpha = 1
        /// Left Part
        menuViewController.imageViewIdea.transform = CGAffineTransform.identity
        menuViewController.imageViewPlayer.transform = CGAffineTransform.identity
        menuViewController.imageViewStar.transform = CGAffineTransform.identity
        /// Right Part
        menuViewController.imageViewLike.transform = CGAffineTransform.identity
        menuViewController.imageViewPlaceholder.transform = CGAffineTransform.identity
        menuViewController.imageViewUser.transform = CGAffineTransform.identity
        
    }
    
}

//==============================//
// MARK:      UIViewControllerAnimatedTransitioning
//=============================//
extension MenuTransitionManager : UIViewControllerTransitioningDelegate{
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    
}



//==============================//
// MARK:      UIViewControllerAnimatedTransitioning
//=============================//
extension MenuTransitionManager : UIViewControllerAnimatedTransitioning{
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        guard let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) ,
            let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        let menuViewController = !self.presenting ? from : to
        let bottomViewController = !self.presenting ? to : from
        
        if self.presenting {
            self.offStageMenuController(menuViewController: menuViewController as! MenuVC)
        }
        
        /// add to transitionContext.containerView
        container.addSubview(bottomViewController.view)
        container.addSubview(menuViewController.view)
        
        print("presenting: \(presenting)")
        print("bottomViewController: \(bottomViewController)")
        print("menuViewController: \(menuViewController)")
        print("===============")
        
        /// Get transition Duration
        let duration = self.transitionDuration(using: transitionContext)
        
        /// Excute Animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                self.onStageMenuController(menuViewController: menuViewController as! MenuVC)
            } else {
                self.offStageMenuController(menuViewController: menuViewController as! MenuVC)
                
            }
            
        }, completion: { finished in
            //自定义转场动画,执行完之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        })
        
        
        
    }
}



