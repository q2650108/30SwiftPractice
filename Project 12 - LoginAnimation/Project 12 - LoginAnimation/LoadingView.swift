//
//  LoadingView.swift
//  Project 12 - LoginAnimation
//
//  Created by SHUN on 11/28/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class  LoadingView  : NSObject   {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var replicatorLayer : CAReplicatorLayer?
    
    private var loadingMaskView : UIView?
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override init(){
        print("\(self.dynamicType) init")
    }
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    func show( ) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let keyWindow = appDelegate.window!
        
        let mainScreen = UIScreen.mainScreen()
        
        let side : CGFloat  = 160
        
        let startX = ( mainScreen.bounds.size.width - side ) / 2
        let startY = ( mainScreen.bounds.size.height - side ) / 2
        
        let path = CGPathCreateMutable() // 创建转圈的动画
        CGPathAddEllipseInRect(path, nil, CGRectMake( startX  , startY  , side , side ))
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 4
        animationGroup.repeatCount = .infinity
        
        let positionformAnim = CAKeyframeAnimation(keyPath: "position")
        positionformAnim.duration = 4
        positionformAnim.repeatCount = HUGE
        positionformAnim.path = path
        positionformAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.5
        scaleAnimation.duration = 2
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        //        let transformAnim = CABasicAnimation(keyPath: "transform")
        //        transformAnim.duration = 2
        //        transformAnim.repeatCount = HUGE
        //        transformAnim.fromValue = NSValue.init(CATransform3D: CATransform3DMakeScale(1, 1, 1))
        //        transformAnim.toValue = NSValue.init(CATransform3D: CATransform3DMakeScale(0.7, 0.7, 0.1))
        
        //  kCAFillModeForwards     :是在动画开始之后layer迅速进入指定位置开始执行动画并在removedOnCompletion = NO的前提下会停在动画结束的最后位置
        //  kCAFillModeBackwards    :则是在动画开始之前迅速进入指定状态并在动画开始后执行动画，动画结束后迅速返回到layer的本身位置
        //  kCAFillModeBoth         :如果removedOnCompletion = NO那layer会在动画开始之前就会迅速进入动画的初始位置并在执行完动画后停在动画结束的位置，如果removedOnCompletion = YES那layer会在动画开始之前就会迅速进入动画的初始位置并在执行完动画后迅速返回到layer的本身位置
        animationGroup.fillMode = kCAFillModeBackwards
        animationGroup.animations = [ positionformAnim , scaleAnimation ]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.whiteColor().CGColor
        shapeLayer.bounds = CGRectMake( 0 , 0 , 20 , 20 )
        //shapeLayer.position = CGPointMake( -side  , -side )
        shapeLayer.cornerRadius = 10
        
        shapeLayer.addAnimation(animationGroup, forKey: nil)
        
        replicatorLayer = CAReplicatorLayer()
        guard let _replicatorLayer = replicatorLayer else {
            return
        }
        _replicatorLayer.addSublayer(shapeLayer)
        
        _replicatorLayer.repeatCount = HUGE
        _replicatorLayer.instanceCount = 6
        _replicatorLayer.instanceDelay = 0.2
        _replicatorLayer.instanceColor = UIColor.blackColor().CGColor
        _replicatorLayer.instanceRedOffset = 0.0
        _replicatorLayer.instanceGreenOffset = 0.0
        _replicatorLayer.instanceBlueOffset = 0.0
        _replicatorLayer.instanceAlphaOffset = -0.1
        
        loadingMaskView = UIView(frame: CGRectMake(0, 0, mainScreen.bounds.width, mainScreen.bounds.height))
        loadingMaskView!.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        keyWindow.addSubview(loadingMaskView!)
        keyWindow.layer.addSublayer(_replicatorLayer)
        
    }
    
    func remove() {
        if let loadingView = self.loadingMaskView{
            replicatorLayer?.sublayers?.forEach({
                $0.sublayers?.forEach({
                    $0.removeAllAnimations()
                    $0.removeFromSuperlayer()
                })
                
                $0.removeAllAnimations()
                $0.removeFromSuperlayer()
            })
            
            replicatorLayer?.removeFromSuperlayer()
            loadingView.removeFromSuperview()
        }
    }
    
}