//
//  AnimationVC.swift
//  Project 25 - UIViewBasicAnimation
//
//  Created by SHUN on 1/17/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class AnimationVC: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var viewBackground: UIView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        switch self.title ?? ""{
        case "Opacity":
            
            UIView.animate(withDuration: 2, animations: {
                self.viewBackground.alpha = 0
            })
            
        case "Color":
            
            UIView.animate(withDuration: 2, animations: {
                self.viewBackground.backgroundColor = UIColor.red
            })
            
        case "Scale":
            
            UIView.animate( withDuration: 1 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1 , options: .curveEaseIn, animations: { () -> Void in
                
                self.viewBackground.transform = CGAffineTransform(scaleX: 3 , y: 3 )
                
            }, completion: nil )
            
        case "Rotation":
            
            UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [.repeat, .autoreverse], animations: { () -> Void in
                
                self.viewBackground.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            })
            
        default:
            print("default")
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
