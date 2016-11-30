//
//  RippleView.swift
//  Project 12 - LoginAnimation
//
//  Created by SHUN on 11/29/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class RippleView  : NSObject  {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    private weak var parentView : UIView?
    
    private var tapPoint : CGPoint?
    
    private var replicatorLayer : CAReplicatorLayer?
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    /// - parameters:
    ///   - parentView: Parent View
    init( parentView : UIView   ) {
        self.parentView = parentView
        
        replicatorLayer = CAReplicatorLayer()
        replicatorLayer?.instanceCount = 3
        replicatorLayer?.instanceDelay = 0.3
        self.parentView?.layer.addSublayer(replicatorLayer!)
    }
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    /// Set Tap Point X and Y
    /// - parameters:
    ///   - touchPoint: Tap Point X and Y
    func setTapPoint(touchPoint : CGPoint){
        self.tapPoint = touchPoint
    }
    
    func show(){
        let mainScreen = UIScreen.mainScreen()
        let width = mainScreen.bounds.width * 0.05
        
        let ovalLayer = CAShapeLayer()
        ovalLayer.backgroundColor = UIColor.redColor().CGColor
        
        ovalLayer.bounds = CGRectMake( 0 , 0 , width, width)
        ovalLayer.position = CGPointMake(self.tapPoint!.x , self.tapPoint!.y)
        ovalLayer.cornerRadius = width / 2
        
        // 放大的动画
        let transformAnim = CABasicAnimation(keyPath: "transform")
        let value = NSValue.init(CATransform3D: CATransform3DMakeScale(10, 10, 1))
        transformAnim.toValue = value
        transformAnim.duration = 1
        
        // 透明度动画(其实也可以直接设置CAReplicatorLayer的instanceAlphaOffset来实现)
        let alphaAnim = CABasicAnimation(keyPath: "opacity")
        alphaAnim.toValue = 0
        alphaAnim.duration = 1
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [transformAnim,alphaAnim]
        animGroup.duration = 1
        animGroup.repeatCount = 0
        
        /// Set Animation delegate
        animGroup.setValue("RippleView", forKey: "KeyRippleView")
        animGroup.delegate = self
        
        ovalLayer.addAnimation(animGroup, forKey: nil)
        
        replicatorLayer?.addSublayer(ovalLayer)
    }
    
    func remove() {
        replicatorLayer?.sublayers?.forEach({
            $0.sublayers?.forEach({
                $0.removeAllAnimations()
                $0.removeFromSuperlayer()
            })
            
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
        })
    }
    
    //==============================//
    // MARK:      Animation Delegate
    //=============================//
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag{
            if let animationID: AnyObject = anim.valueForKey("KeyRippleView") {
                if animationID as! NSString == "RippleView" {
                    remove()
                }
            }
        }
    }
    
}
