//
//  ViewController.swift
//  Project 16 - SlideMenu
//
//  Created by SHUN on 12/29/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController , CAAnimationDelegate {
    
    @IBOutlet weak var viewRotation: UIView!
    
    @IBOutlet weak var viewRotation2: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTouchUpInside(_ sender: Any) {
        
        /// 關閉隱式動畫
        CATransaction.setDisableActions(true)
        
        
        viewRotation2.layer.zPosition = 1
        
        //起始值
        var fromValue = CATransform3DIdentity
        fromValue.m34 = -1.0 / 900
        fromValue = CATransform3DRotate(fromValue , CGFloat(180.degreesToRadians) , 1 , 0 , 0)
        // 结束值
        var toValue = CATransform3DIdentity
        toValue.m34 = -1.0 / 1000
        toValue = CATransform3DRotate(toValue, CGFloat(0.degreesToRadians) , 0 , 0 , 0)
        
        // 添加3D动画
        let transform3DAnimation = CABasicAnimation(keyPath: "transform")
        transform3DAnimation.beginTime = 0.0
        transform3DAnimation.duration = 0.5
        transform3DAnimation.fromValue = NSValue(caTransform3D:fromValue)
        transform3DAnimation.toValue = NSValue(caTransform3D:toValue)
        
        
        //        //起始值
        //        var fromValue2 = CATransform3DIdentity
        //        fromValue2.m34 = -1.0 / 700
        //        fromValue2 = CATransform3DRotate(fromValue , CGFloat(0.degreesToRadians)  , 1 , 0 , 0)
        //        // 结束值
        //        var toValue2 = CATransform3DIdentity
        //        toValue2.m34 = -1.0 / 1000
        //        toValue2 = CATransform3DRotate(toValue,  CGFloat(180.degreesToRadians)   , 0 , 0 , 0)
        //
        //        let transform3D2Animation = CABasicAnimation(keyPath: "transform")
        //        transform3DAnimation.beginTime = transform3DAnimation.beginTime + transform3DAnimation.duration
        //        transform3D2Animation.duration = 1.0
        //        transform3D2Animation.fromValue = NSValue(caTransform3D:fromValue2)
        //        transform3D2Animation.toValue = NSValue(caTransform3D:toValue2)
        
        
        let fromPosition = viewRotation2.frame.origin.y
        let toPosition =  viewRotation2.frame.origin.y
        
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.beginTime = 0.0
        positionAnimation.duration = 0.5
        positionAnimation.fromValue = fromPosition
        positionAnimation.toValue = toPosition
        
        
        
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [ transform3DAnimation , positionAnimation ]
        animationGroup.duration = 0.5
        animationGroup.repeatCount = 0
        animationGroup.delegate = self
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = kCAFillModeForwards
        viewRotation2.layer.add(animationGroup, forKey: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let oldFrame = self.viewRotation2.frame
        self.viewRotation2.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        self.viewRotation2.frame  = oldFrame
        
        //        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        //        aView.backgroundColor = UIColor.black
        //        self.view.addSubview(aView)
        //
        //        print("view's bounds: \(aView.bounds)")
        //        print("view's frame: \(aView.frame)")
        //        print("view's center: \(aView.center)")
        //
        //        print("layer's bounds: \(aView.layer.bounds)")
        //        print("layer's frame: \(aView.layer.frame)")
        //        print("layer's position: \(aView.layer.position)")
        //        print("layer's anchorPoint: \(aView.layer.anchorPoint)")
        //
        //        aView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        //
        //        print()
        //        print("view's bounds: \(aView.bounds)")
        //        print("view's frame: \(aView.frame)")
        //        print("view's center: \(aView.center)")
        //
        //        print("layer's bounds: \(aView.layer.bounds)")
        //        print("layer's frame: \(aView.layer.frame)")
        //        print("layer's position: \(aView.layer.position)")
        //        print("layer's anchorPoint: \(aView.layer.anchorPoint)")
    }
    
    
    
    func animationDidStart(_ anim: CAAnimation) {
        self.viewRotation2.subviews[0].isHidden = true
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
       // self.viewRotation2.isHidden = true
    }
}

/// ====  removedOnCompletion属性 ====
//      removedOnCompletion：
//          默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置        为NO，不过还
//          要设置fillMode为kCAFillModeForwards

/// ====  fillMode属性 ====
//      fillMode：
//          决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后
//      kCAFillModeRemoved :
//          这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态（可以理解为动画执行完成后移除）
//      kCAFillModeForwards :
//          当动画结束后,layer会一直保持着动画最后的状态
//      kCAFillModeBackwards :
//          当在动画开始前,你只要把layer加入到一个动画中,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,延迟3秒让动画开始,只要动画被加入了layer,layer便处于动画初始状态

