//
//  MenuVC.swift
//  Project 17 - TumblrMenu
//
//  Created by SHUN on 1/4/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    let transitionManager = MenuTransitionManager()
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var imageViewIdea: UIImageView!
    
    @IBOutlet weak var imageViewLike: UIImageView!
    
    @IBOutlet weak var imageViewPlayer: UIImageView!
    
    @IBOutlet weak var imageViewPlaceholder: UIImageView!
    
    @IBOutlet weak var imageViewStar: UIImageView!
    
    @IBOutlet weak var imageViewUser: UIImageView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self.transitionManager
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
