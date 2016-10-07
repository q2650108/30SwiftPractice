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
    //      Pirvate Property       //
    ////////////////////////////////
    
    /// timer
    private var timer : NSTimer!
    
    /// count the time
    private var time : Float = 0.0
    
    /// Swith the Timer On or Off
    private var isTimerOn : Bool = false
    
    //////////////////////////////////
    //      Public Property        //
    ////////////////////////////////
    
    
    
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
        initTimer()
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
        stopTiemr()
    }
    
    //////////////////////////////////
    //      Action                 //
    ////////////////////////////////
    
    
    
    @IBAction func ButtonStartTouchUpInside(sender: AnyObject) {
        // Timer On
        
        if let _ = timer {
            isTimerOn = true
        }else{
            // if timer stop , need to new timer
            initTimer()
        }
    }
    
    @IBAction func ButtonPauseTouchUpInside(sender: AnyObject) {
        // Timer Off
        isTimerOn = false
    }
    
    @IBAction func ButtonResetTouchUpInside(sender: AnyObject) {
        
        stopTiemr()
        
        // Reset the Time
        time = 0.0
        LabelTime.text = "\(time)"
    }
    
    //////////////////////////////////
    //      Private Func           //
    ////////////////////////////////
    
    private func initUI(){
    }
    
    private func setUI(){
        
    }
    
    private func initTimer(){
        // per 0.1 sec
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.calculateTime), userInfo: nil, repeats: true)
    }
    
    
    @objc private func calculateTime(){
        if(isTimerOn){
            time += 0.1
            
            // fix time += 0.1 Display some wrong value
            // ex: 8.0999
            let value =  round(10 * time) / 10
            LabelTime.text = "\(value)"
        }
    }
    
    private func stopTiemr(){
        // Clear the timer
        timer.invalidate()
        timer = nil
    }
    
    
    //////////////////////////////////
    //      Public Func            //
    ////////////////////////////////
    
    
}

