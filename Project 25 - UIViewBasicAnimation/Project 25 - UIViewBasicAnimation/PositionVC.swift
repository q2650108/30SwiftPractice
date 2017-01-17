//
//  PositionVC.swift
//  Project 25 - UIViewBasicAnimation
//
//  Created by SHUN on 1/16/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class PositionVC: UIViewController {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    let identitfPositionformAnim : String = "positionformAnim"
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var labelShift: UILabel!
    
    @IBOutlet weak var labelRound: UILabel!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        showShiftAnimation()
        showRoundAnimation()
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
        labelRound.isHidden = true
        
    }
    
    private func showShiftAnimation(){
        
        
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [.repeat, .autoreverse], animations: { () -> Void in
            
            let translatedX = self.view.frame.width - self.labelShift.frame.width - self.labelShift.frame.origin.x - 20
            let translatedY : CGFloat = 0.0
            
            self.labelShift.transform = CGAffineTransform(scaleX: 0.9, y: 1.1).translatedBy(x: translatedX , y:  translatedY )
        }, completion: {
            (finished : Bool ) -> () in
            
            UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut,animations: { () -> Void in
                
                self.labelShift.transform = .identity
            })
            
        } )
        
    }
    
    private func showRoundAnimation(){
        
        /// round the view
        labelRound.layer.cornerRadius = labelRound.frame.width / 2
        labelRound.clipsToBounds = true
        
        let radius = labelRound.frame.width * 2
        
        let startX = labelRound.frame.midX
        let startY = labelRound.frame.midY
        
        /// Path
        let circlePath = UIBezierPath(arcCenter: CGPoint(x:startX , y: startY), radius: radius , startAngle: 0, endAngle:CGFloat(M_PI)*2, clockwise: true)
        
        let positionformAnim = CAKeyframeAnimation(keyPath: "position")
        positionformAnim.duration = 4
        positionformAnim.repeatCount = HUGE
        positionformAnim.path = circlePath.cgPath
        positionformAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        /// delegate
        positionformAnim.delegate = self
        positionformAnim.setValue(String(describing: labelRound), forKey: identitfPositionformAnim)
        
        
        labelRound.layer.add(positionformAnim, forKey: nil)
        
 
        // circleLayer is only used to locate the circle animation path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(circleLayer)
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
}


extension PositionVC : CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        
        
        guard let positionformAnimAny = anim.value(forKey: identitfPositionformAnim) , let positionformAnimValue =  positionformAnimAny as? String else {
            return
        }
        
        if positionformAnimValue  == String(describing: labelRound) {
            labelRound.isHidden = false
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {

        
    }
    
    
}

