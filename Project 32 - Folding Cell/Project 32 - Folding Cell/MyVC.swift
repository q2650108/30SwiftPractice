//
//  MyVC.swift
//  Project 32 - Folding Cell
//
//  Created by SHUN on 2/22/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MyVC: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBAction func tap(_ sender: Any) {
        
        //        var fromTrans = CATransform3DIdentity;
        //        //设定视觉焦点，分母越大表示视图离我们的距离越远，数值大有什么好处呢，你会发现翻转效果就不会产生你讨厌的侧边幅度过大的问题。
        //        fromTrans.m34 = -1.0 / 600.0
        //        fromTrans = CATransform3DRotate(fromTrans, CGFloat(0.degreesToRadians), 1, 0, 0)//沿 X 轴旋转180度
        //
        //        var toTrans = CATransform3DIdentity;
        //        toTrans.m34 = -1.0 / 700.0
        //        toTrans = CATransform3DRotate(toTrans, CGFloat(180.degreesToRadians), 1, 0, 0)
        
        var fromTrans = CATransform3DIdentity;
        //设定视觉焦点，分母越大表示视图离我们的距离越远，数值大有什么好处呢，你会发现翻转效果就不会产生你讨厌的侧边幅度过大的问题。
        fromTrans.m34 = -1.0 / 600.0
        fromTrans = CATransform3DRotate(fromTrans, CGFloat(0.degreesToRadians), 1, 0, 0)//沿 X 轴旋转180度
        
        var toTrans = CATransform3DIdentity;
        toTrans.m34 = -1.0 / 700.0
        toTrans = CATransform3DRotate(toTrans, CGFloat(179.degreesToRadians) , 1, 0, 0)
        
        
        
        let basicAnimate = CABasicAnimation(keyPath: "transform")
        basicAnimate.fromValue = NSValue(caTransform3D: fromTrans)
        basicAnimate.toValue = NSValue(caTransform3D: toTrans)
        
        basicAnimate.duration = 5
        basicAnimate.fillMode = kCAFillModeForwards
        basicAnimate.isRemovedOnCompletion = false
        view2.layer.add(basicAnimate, forKey: nil)
        
        
        
        let fadeAndScale = CAAnimationGroup()
        fadeAndScale.animations = [basicAnimate]
        fadeAndScale.duration = 5
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view2.layer.anchorPoint = CGPoint(x:0.5, y:0)
        view2.frame.origin.y = view2.frame.origin.y - view2.frame.height / 2
        
        
        //        view2.layer.anchorPoint = CGPoint(x:0.5, y:1)
        //        view2.frame.origin.y = view2.frame.origin.y - view2.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
