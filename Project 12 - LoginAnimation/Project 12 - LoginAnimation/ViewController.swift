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
    private var loadingStatus : Bool = false
    
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
        if !loadingStatus {
            loadingStatus = true
            customLoadingView = CustomLoadingView()
            customLoadingView?.show()
            buttonLogin.titleLabel?.text = "Loading ..."
            
            /// Simulate the api response , when 8 sec later
            NSTimer.scheduledTimerWithTimeInterval( 8 ,
                                                    target:self,selector:#selector(self.handleTimer),
                                                    userInfo:nil,repeats:false)
            
        }
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
 
        loadingStatus = false
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

