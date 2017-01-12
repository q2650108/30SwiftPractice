//
//  MenuItemVC.swift
//  Project 23 - SlideOutMenu
//
//  Created by SHUN on 1/12/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import SWRevealViewController
import UIKit

class MenuItemVC: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    var selectedMenuItem : Int = 0
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    @IBOutlet weak var buttonMenu: UIBarButtonItem!
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            buttonMenu.target = self.revealViewController()
            buttonMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        /// rearView Reveal Width
        self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.7
        
        self.title = "MenuItemVC - \(selectedMenuItem)"
        
        
        switch selectedMenuItem {
        case 0:
            self.view.backgroundColor = UIColor.red
        case 1:
            self.view.backgroundColor = UIColor.yellow
        case 2:
            self.view.backgroundColor = UIColor.blue
        default:
            self.view.backgroundColor = UIColor.white
        }
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
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //        guard let indexPath = tableView.indexPathForSelectedRow else{
        //            return
        //        }
        print("MenuItem")
        print(segue.source)
        print(segue.destination)
        
    }
    
    
}
