//
//  NavigationController.swift
//  Project 03 - Play Local Video
//
//  Created by SHUN on 10/12/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController ,UINavigationControllerDelegate{
   //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
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
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    //==============================//
    // MARK:      UINavigationControllerDelegate
    //=============================//

    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        navigationController.hidesBarsOnSwipe  = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
