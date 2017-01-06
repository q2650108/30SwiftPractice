//
//  ViewController.swift
//  Project 18 - LimitCharacters
//
//  Created by SHUN on 1/6/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private let _maxLength = 5
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    var maxLength : Int {
        get {
            return _maxLength
        }
    }
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var textFieldInput: UITextField!
    
    @IBOutlet weak var viewFooterMenu: UIView!
    
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBOutlet weak var lableLength: UILabel!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func buttonClearTouchUpInside(_ sender: Any) {
        /// Clear the Text Field
        textFieldInput.text =  ""
        lableLength.text = "\(maxLength)"
    }
    
    //==============================//
    // MARK:     Handle Selector
    //=============================//
    
    func keyBoardWillShow(note:NSNotification) {
        
        let userInfo  = note.userInfo
        let keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            
            self.viewFooterMenu.transform = CGAffineTransform(translationX: 0,y: -deltaY)
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else {
            
            animations()
        }
        
    }
    
    
    func keyBoardWillHide(note:NSNotification) {
        
        let userInfo  = note.userInfo
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            
            self.viewFooterMenu.transform = CGAffineTransform.identity
            
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            
            animations()
        }
        
    }
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lableLength.text = "\(maxLength)"
        
        textFieldInput.delegate = self
        
        /// Add NSNotificationCenter
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyBoardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    //==============================//
    // MARK:      Self Func
    //=============================//
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// when Touch the others view , close the keyboard
        view.endEditing(true)
    }
    
}

//==============================//
// MARK:      UITextField Delegate
//=============================//


extension ViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textFieldInput.text  else {
            return false
        }
        
        let currentString = NSString(string: text)
        let newString = NSString(string: currentString.replacingCharacters(in: range, with: string) )
        
        
        if newString.length <= maxLength {
            /// Display the Remaining Length
            lableLength.text = "\(maxLength - newString.length)"
            return true
        }else{
            //        print("range : \(range.length) , \(range.location)")
            //        print("string : \(string)")
            //        print("text : \(text)")
            //        print("     : \(currentString) , \(newString)")
            //        print("===========")
            return false
        }
    }
    
}

