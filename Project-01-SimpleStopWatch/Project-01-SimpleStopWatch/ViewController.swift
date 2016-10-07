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
        initUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{

    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("viewWillTransitionToSize Landscape")
        } else {
            print("viewWillTransitionToSize Portrait")
        }
     
        coordinator.animateAlongsideTransition(nil, completion: {
        
            transitionCoordinatorContext  in
            
                self.setUI()
        })
    }
    

    
    //////////////////////////////////
    //      Private Func           //
    ////////////////////////////////
    
    private func initUI(){
    }
    
    private func setUI(){
        // let the font size fit the Frame
        LabelTime.adjustFontSizeToFitRect(LabelTime.frame)
        ButtonReset.titleLabel!.adjustFontSizeToFitRect(ButtonReset.frame)
    }
    
    //////////////////////////////////
    //      Public Func            //
    ////////////////////////////////
    
    
}

