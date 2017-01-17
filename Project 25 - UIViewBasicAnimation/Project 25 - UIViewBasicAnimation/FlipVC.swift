//
//  FlipVC.swift
//  Project 25 - UIViewBasicAnimation
//
//  Created by SHUN on 1/17/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class FlipVC: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var viewFront: UIView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.transition(from: viewFront , to: viewBack , duration: 1.5, options:  [.repeat, .autoreverse , .transitionFlipFromRight] , completion: {
            (finished : Bool ) -> () in
            
            guard let viewBack = self.viewBack , let viewFront =  self.viewFront else {
                return
            }
            
            UIView.transition(from: viewBack , to: viewFront , duration: 1.5, options:  [ .transitionFlipFromLeft ] ,completion: nil )
            
        } )
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
