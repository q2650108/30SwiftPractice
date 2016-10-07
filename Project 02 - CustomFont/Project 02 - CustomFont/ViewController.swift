//
//  ViewController.swift
//  Project 02 - CustomFont
//
//  Created by SHUN on 10/7/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //==============================//
    //      Pirvate Property       //
    //=============================//
    
    /// Test Fonts Array
    private let fontsArray : [String] = [ "MaxterBoardSt" ,
                                          "RemachineScriptPersonalUse" ,
                                          "WaltographUI-Bold" ]
    /// current Fonts Index
    private var fontsIndex : Int = 0
    
    //==============================//
    //      Public Property        //
    //=============================//
    
    
    
    //==============================//
    //      Layout Property        //
    //=============================//
    
    @IBOutlet weak var LabelContent: UILabel!
    
    @IBOutlet weak var buttonChangeFont: UIButton!
    
    //==============================//
    //      Action                 //
    //=============================//
    
    @IBAction func buttonChangeFontTouchUpInside(sender: AnyObject) {
        chnageFont()
    }
    
    
    //==============================//
    //      Life Cycle             //
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        
    }
    
    //==============================//
    //      Style Seetting          //
    //=============================//
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //==============================//
    //      Private Func           //
    //=============================//
    
    private func initUI(){
        
        // set some String for test
        LabelContent.text = "World's best city for expats revealed" +
            "\"Despite recent security issues, social unrest and concern about the region's economic outlook, European cities continue to offer some of the world's highest quality of living,\" Mercer says" +
            "The top five is rounded out by New Zealand's biggest city, Auckland, and Vancouver on Canada's west coast." +
            "Singapore is Asia's highest ranking city, taking th place, Dubai claims top ranking for the Middle East at, while Africa's only two destinations to make the top are Cape Town at and Johannesburg at." +
        "The study of cities evaluated standards of safety, health, schools, recreation, environment, public services and cakes (well, OK, consumer goods)."
        
    }
    
    private func setUI(){
        setCircular(buttonChangeFont)
    }
    
    
    private func chnageFont(){
        // Keep the original Font
        let tempFont = LabelContent.font
        // Set the New Font Name , the old Font Size
        LabelContent.font = UIFont(name: fontsArray[fontsIndex], size: tempFont.pointSize)
        // save the New Index
        fontsIndex = (fontsIndex + 1) % fontsArray.count
    }
    
    /// Let round View
    /// view Requires square
    ///- parameter Any UIVIew
    private func setCircular(view:UIView){
        view.layer.cornerRadius = 0.5 * view.bounds.size.width
        view.clipsToBounds = true
    }
    
    
    /// To get the list of fonts displayed in console log
    private func searchLocalFont(){
        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }
    }
    
    //==============================//
    //      Public Func            //
    //=============================//
    
    
    
}

