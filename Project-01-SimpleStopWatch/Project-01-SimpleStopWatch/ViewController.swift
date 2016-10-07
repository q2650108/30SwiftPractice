//
//  ViewController.swift
//  Project-01-SimpleStopWatch
//
//  Created by SHUN on 10/6/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //////////////////////////////////
    //      Layout Property        //
    ////////////////////////////////
    
    /// Display the Current Time
    @IBOutlet weak var LabelTime: UILabel!
    
    /// Reset the Time
    @IBOutlet weak var ButtonReset: UIButton!
    
    /// Start or continue the Time
    @IBOutlet weak var ButtonStart: UIButton!
    
    /// Pause th Time
    @IBOutlet weak var ButtonPause: UIButton!
    
    //////////////////////////////////
    //      Life Cycle             //
    ////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    //////////////////////////////////
    //      Private Func           //
    ////////////////////////////////
    
    private func initUI(){
        LabelTime.adjustFontSizeToFitRect(LabelTime.frame)
        ButtonReset.titleLabel!.adjustFontSizeToFitRect(ButtonReset.frame)
    }
    
    //////////////////////////////////
    //      Public Func            //
    ////////////////////////////////
    
    
}

