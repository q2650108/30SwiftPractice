//
//  FirstVC.swift
//  Project 12 - LoginAnimation
//
//  Created by SHUN on 11/28/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var ButtonNext: UIButton!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func ButtonNextTouchUpInside(sender: AnyObject) {
        /// Go next VC
        self.performSegueWithIdentifier("showSecond", sender: nil)
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        initValue()
        animate()
    }
    
    deinit{
        print("\(self.dynamicType) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        ButtonNext.layer.cornerRadius = 0.5 * ButtonNext.bounds.size.width
        ButtonNext.clipsToBounds = true
        
    }
    
    private func animate(){
        /// usingSpringWithDamping：弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
        //  initialSpringVelocity：弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果。
        UIView.animateWithDuration( 1.5 , delay: 0.5, usingSpringWithDamping: 0.3 , initialSpringVelocity: 0.3 , options: .AllowUserInteraction, animations: {
            self.ButtonNext.center.y = self.view.center.y
            }, completion: nil)
        
    }
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
}
