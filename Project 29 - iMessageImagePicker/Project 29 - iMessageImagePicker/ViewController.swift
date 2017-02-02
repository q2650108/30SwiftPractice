//
//  ViewController.swift
//  Project 29 - iMessageImagePicker
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit
import ImagePickerTrayController

class ViewController: UIViewController  {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    fileprivate var imagePickerTrayController: ImagePickerTrayController?
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    
    //==============================//
    // MARK:     Action
    //=============================//

    @IBAction func handleTap( _ sender: UITapGestureRecognizer ){
        if imagePickerTrayController != nil {
            hideImagePickerTray()
        }
        else {
            showImagePickerTray()
        }
    }
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageViewProfile.layer.cornerRadius = imageViewProfile.bounds.width / 2
        imageViewProfile.layer.masksToBounds = true
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
    
    
    fileprivate func showImagePickerTray() {
        let controller = ImagePickerTrayController()
        controller.add(action: .cameraAction { _ in
            print("Show Camera")
            })
        controller.add(action: .libraryAction { _ in
            print("Show Library")
            })
        controller.show(in: view)
        imagePickerTrayController = controller
    }
    
    fileprivate func hideImagePickerTray() {
        imagePickerTrayController?.hide()
        imagePickerTrayController = nil
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
}

