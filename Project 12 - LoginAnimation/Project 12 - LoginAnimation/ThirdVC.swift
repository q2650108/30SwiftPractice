//
//  ThirdVC.swift
//  Project 12 - LoginAnimation
//
//  Created by SHUN on 11/29/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ThirdVC: UIViewController {
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var rippleView : RippleView?
    
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
    // MARK:     Handle - Gesture
    //=============================//
    
    @IBAction func handleTapView( sender: UITapGestureRecognizer ) {
        
        if sender.state == .Ended {
            
            if rippleView == nil {
                rippleView = RippleView(parentView: self.view)
            }

            let touchPoint = sender.locationInView(self.view)
            rippleView?.setTapPoint(touchPoint)
            rippleView?.show()
        } 
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
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    
    
    
}
