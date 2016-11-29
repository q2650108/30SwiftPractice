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
