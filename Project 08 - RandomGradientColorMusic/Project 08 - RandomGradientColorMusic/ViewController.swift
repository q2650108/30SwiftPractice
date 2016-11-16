//
//  ViewController.swift
//  Project 08 - RandomGradientColorMusic
//
//  Created by SHUN on 11/15/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var colorArray : [ CGColor ] = [ CGColor ]()
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var sliderStartX: UISlider!
    
    @IBOutlet weak var sliderEndX: UISlider!
    
    @IBOutlet weak var sliderStartY: UISlider!
    
    @IBOutlet weak var sliderEndY: UISlider!
    
    @IBOutlet weak var sliderR: UISlider!
    
    @IBOutlet weak var sliderG: UISlider!
    
    @IBOutlet weak var sliderB: UISlider!
    
    @IBOutlet weak var sliderAlpha: UISlider!
    
    @IBOutlet weak var labelValueStartX: UILabel!
    
    @IBOutlet weak var labelValueEndX: UILabel!
    
    @IBOutlet weak var labelValueStartY: UILabel!
    
    @IBOutlet weak var labelValueEndY: UILabel!
    
    @IBOutlet weak var labelValueR: UILabel!
    
    @IBOutlet weak var labelValueG: UILabel!
    
    @IBOutlet weak var labelValueB: UILabel!
    
    @IBOutlet weak var labelValueAlpha: UILabel!
    /// Display the Preview Color
    @IBOutlet weak var viewPreview: UIView!
    /// Display the Color Queue
    @IBOutlet weak var viewColorQueue: UIView!
    
    @IBOutlet weak var viewResult: UIView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func sliderStartXValueChanged(sender: UISlider) {
        labelValueStartX.text = "\(  Float( Int(sender.value * 10 )) / 10  )"
    }
    
    @IBAction func sliderEndXValueChanged(sender: UISlider) {
        labelValueEndX.text  = "\(  Float( Int(sender.value * 10 )) / 10  )"
    }
    
    @IBAction func sliderStartYValueChanged(sender: UISlider) {
        labelValueStartY.text = "\(  Float( Int(sender.value * 10 )) / 10  )"
    }
    
    @IBAction func sliderEndYValueChanged(sender: UISlider) {
        labelValueEndY.text  = "\(  Float( Int(sender.value * 10 )) / 10  )"
    }
    
    
    @IBAction func sliderRValueChanged(sender: UISlider) {
        labelValueR.text = "\( Int( sender.value ))"
        /// Get Current Preview Color
        showPreviewColor()
    }
    
    @IBAction func sliderGValueChanged(sender: UISlider) {
        labelValueG.text = "\( Int( sender.value ))"
        /// Get Current Preview Color
        showPreviewColor()
    }
    
    @IBAction func sliderBValueChanged(sender: UISlider) {
        labelValueB.text = "\( Int( sender.value ))"
        /// Get Current Preview Color
        showPreviewColor()
    }
    
    @IBAction func sliderAlphaValueChanged(sender: UISlider) {
        labelValueAlpha.text  = "\(  Float( Int(sender.value * 10 )) / 10  )"
        /// Get Current Preview Color
        showPreviewColor()
    }
    
    @IBAction func buttonPlusTouchUpInside(sender: AnyObject) {
        
        guard let color = self.viewPreview.backgroundColor else {
            return
        }
        
        self.colorArray.append( color.CGColor )
        
        /// show Color Queue View
        showColorQueue()
    }
    
    @IBAction func buttonMinusTouchUpInside(sender: AnyObject) {
        if self.colorArray.count > 0 {
            self.colorArray.removeLast()
            
        }
        /// show Color Queue View
        showColorQueue()
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initValue()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        showPreviewColor()
        
    }
    
    private func showResult(){
        /// Default Value
        self.viewResult.backgroundColor = UIColor.whiteColor()
        
        if self.colorArray.count > 0{
            
            /// removew ALL layer
            self.viewResult.layer.sublayers?.forEach( { $0.removeFromSuperlayer() })
            /// Get Location
            var locationArray : [ CGFloat ] =  [ CGFloat ]()
            var totalLocation : CGFloat = 0.0
            let perLocation : CGFloat = 1 / CGFloat( self.colorArray.count - 1 )
            
            if self.colorArray .count == 1 {
                /// For only one Color in queue
                locationArray.append(1.0)
                self.viewResult.backgroundColor = UIColor(CGColor: self.colorArray[0])
            }else {
                for _ in  self.colorArray {
                    locationArray.append(totalLocation)
                    totalLocation += perLocation
                }
                
                let gradientLayer : CAGradientLayer = CAGradientLayer()
                /// Set gradientLayer
                gradientLayer.frame = self.viewResult.bounds
                
                gradientLayer.colors =  self.colorArray
                gradientLayer.locations = locationArray
                gradientLayer.startPoint = CGPoint(x:  CGFloat( NSNumberFormatter().numberFromString(self.labelValueStartX.text!)! ),
                                                   y: CGFloat( NSNumberFormatter().numberFromString(self.labelValueStartY.text!)! ) )
                gradientLayer.endPoint = CGPoint(x:  CGFloat( NSNumberFormatter().numberFromString(self.labelValueEndX.text!)! ),
                                                 y: CGFloat( NSNumberFormatter().numberFromString(self.labelValueEndY.text!)! ) )
                
                dispatch_async(dispatch_get_main_queue(),{
                    
                    self.viewResult.layer.insertSublayer(gradientLayer, atIndex: 0)
                    
                })
            }
        }
    }
    
    private func showColorQueue(){
        /// Clear the all Subview
        self.viewColorQueue.subviews.forEach( { $0.removeFromSuperview() })
        
        let perWidth = self.viewColorQueue.frame.width / CGFloat(self.colorArray.count)
        
        var totalX : CGFloat = 0
        
        for color in self.colorArray {
            
            let view = UIView(frame:  CGRectMake(totalX, 0, perWidth , self.viewColorQueue.frame.height ) )
            
            view.backgroundColor = UIColor(CGColor: color)
            
            self.viewColorQueue.addSubview(view)
            
            totalX += perWidth
        }
        
        showResult()
    }
    
    /// set the Preview Color
    private func showPreviewColor(){
        let r = CGFloat( NSNumberFormatter().numberFromString(labelValueR.text!)! )
        let g = CGFloat( NSNumberFormatter().numberFromString(labelValueG.text!)! )
        let b = CGFloat( NSNumberFormatter().numberFromString(labelValueB.text!)! )
        let alpha = CGFloat( NSNumberFormatter().numberFromString(labelValueAlpha.text!)! )
        
        self.viewPreview.backgroundColor = UIColor(red: r / 255 , green: g / 255  , blue: b / 255  , alpha:  alpha )
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    
    
    
    
}

