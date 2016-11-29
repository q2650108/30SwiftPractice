//
//  SecondVC.swift
//  Project 12 - LoginAnimation
//
//  Created by SHUN on 11/28/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var loadingView : LoadingView?
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var buttonNext: UIButton!
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func buttonNextTouchUpInside(sender: AnyObject) {
        buttonNext.setTitle("Loading ...", forState: .Normal)
        
        loadingView = LoadingView()
        loadingView?.show()
        
        
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
        
        initValue()
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
    // MARK:     Hadle - Timer selector 
    //=============================//
    
    /// Simulate the api response
    func handleTimer(){
        buttonNext.setTitle("Go Third VC", forState: .Normal)
        loadingView?.remove()
        loadingView = nil
        self.performSegueWithIdentifier("showThird", sender: nil)
    }
    
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        buttonNext.layer.cornerRadius = 0.5 * buttonNext.bounds.size.width
        buttonNext.clipsToBounds = true
        
    }

    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    
}

