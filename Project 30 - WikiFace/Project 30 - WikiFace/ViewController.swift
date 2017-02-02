//
//  ViewController.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var imageViewContent: UIImageView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initValue()
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
        textFieldName.delegate = self
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    
}

extension ViewController : APIDelegate {
    func APIWikiFace(returnCode: APIEnum , message : String ,returnData: WikiFaceEntity? ) {
//        print("returnCode : \(returnCode)")
//        print("message : \(message)")
//        print("returnData : \(returnData)")
        
        DispatchQueue.main.async {
            self.imageViewContent.image = returnData?.faceImage
        }
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let name = textField.text  else {
            return false
        }
        
        print("\(name)")
        
        APIRequestWikiFace(delegate: self , name: name , size: imageViewContent.frame.size).start()
        
        return true
    }
    
}
