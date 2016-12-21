//
//  ViewController.swift
//  Project 15 - AnimatedSplash
//
//  Created by SHUN on 12/21/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var imageViewStar: UIImageView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateMask()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        
    }
    
    func animateMask() {
        //self.imageViewStar.isHidden = false
        
        let mask = CALayer()
        mask.contents = UIImage(named: "starCenter")?.cgImage
        mask.contentsGravity = kCAGravityResizeAspect
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        
        self.view.layer.mask = mask
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.duration = 0.7
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        
        let initalBounds = NSValue(cgRect: mask.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: mask.bounds.width * 0.5 , height: mask.bounds.height * 0.5  ))
        
        
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: self.view.frame.width * 3 , height: self.view.frame.height * 3 ))
        
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds ]
        
        keyFrameAnimation.fillMode = kCAFillModeForwards
        keyFrameAnimation.isRemovedOnCompletion = false
        
        keyFrameAnimation.delegate = self
        
        /// //每个动作的时间百分比
        keyFrameAnimation.keyTimes = [ 0 , 0.3 , 1]
        
        
        mask.add(keyFrameAnimation, forKey: nil)
        
    }
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
}


extension ViewController : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.view.layer.mask = nil
        //self.imageViewStar.isHidden = true
    }
    
}
