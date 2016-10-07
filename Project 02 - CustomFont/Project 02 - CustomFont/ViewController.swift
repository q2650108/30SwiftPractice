//
//  ViewController.swift
//  Project 02 - CustomFont
//
//  Created by SHUN on 10/7/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //////////////////////////////////
    //      Pirvate Property       //
    ////////////////////////////////
    let fortest:String = ""
    //////////////////////////////////
    //      Public Property        //
    ////////////////////////////////
    
    
    //////////////////////////////////
    //      Layout Property        //
    ////////////////////////////////
    
    
    //////////////////////////////////
    //      Action                 //
    ////////////////////////////////
    
    
    //////////////////////////////////
    //      Life Cycle             //
    ////////////////////////////////
    
    //////////////////////////////////
    //      Private Func           //
    ////////////////////////////////
    
    //////////////////////////////////
    //      Public Func            //
    ////////////////////////////////
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

