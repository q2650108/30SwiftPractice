//
//  ViewController.swift
//  Project 17 - TumblrMenu
//
//  Created by SHUN on 1/4/17.
//  Copyright © 2017 q2650108. All rights reserved.
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
    
    @IBOutlet weak var buttonBackground: UIButton!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:      Navigation
    //=============================//
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        buttonBackground.imageView?.contentMode = .bottom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
   
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
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    
    
}

