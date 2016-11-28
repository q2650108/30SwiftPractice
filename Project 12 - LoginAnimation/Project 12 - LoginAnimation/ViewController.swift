//
//  ViewController.swift
//  Project 12 - LoginAnimation
//
//  Created by SHUN on 11/28/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var timer : NSTimer = NSTimer()
    
    private var customLoadingView : CustomLoadingView?
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func buttonLoginTouchUpInside(sender: AnyObject) {
        buttonLogin.setTitle("Loading ...", forState: .Normal)
        
        customLoadingView = CustomLoadingView()
        customLoadingView?.show()
        
        
        /// Simulate the api response , when 8 sec later
        NSTimer.scheduledTimerWithTimeInterval( 8 ,
                                                target:self,selector:#selector(self.handleTimer),
                                                userInfo:nil,repeats:false)
    }
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("viewDidLoad")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //print("viewWillAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    override func viewDidLayoutSubviews() {
        //print("viewDidLayoutSubviews")
        
        
    }
    
    //==============================//
    // MARK:      Timer selector Hadle
    //=============================//
    
    /// Simulate the api response
    func handleTimer(){
               buttonLogin.setTitle("Sign In", forState: .Normal)
        customLoadingView?.remove()
        customLoadingView = nil
        stopTimer()
        
    }
    
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func stopTimer(){
        timer.invalidate()
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    
}

