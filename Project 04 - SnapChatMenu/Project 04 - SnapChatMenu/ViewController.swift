//
//  ViewController.swift
//  Project 04 - SnapChatMenu
//
//  Created by kinpomis on 2016/10/14.
//  Copyright © 2016年 kinpomis. All rights reserved.
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
    
    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func segmentedValueChanged(sender: AnyObject) {

        switch segmented.selectedSegmentIndex{
        case 0:
            /// Square
            
            imageView.layer.cornerRadius = 0
            imageView.clipsToBounds = true
            
            break
        case 1:
            /// Circle
            
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            
            break
        default:
            break
        }
        
    }
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
    
}

