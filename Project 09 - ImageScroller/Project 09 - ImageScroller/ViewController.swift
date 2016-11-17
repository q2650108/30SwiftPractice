//
//  ViewController.swift
//  Project 09 - ImageScroller
//
//  Created by SHUN on 11/17/16.
//  Copyright © 2016 q2650108. All rights reserved.
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageViewContent: UIImageView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initValue()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    private func initValue(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    


}


extension ViewController : UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageViewContent
    }

}

