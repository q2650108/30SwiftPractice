//
//  ViewController.swift
//  Project 14 - EmojiSlotMachine
//
//  Created by SHUN on 12/21/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    var rowCount = 100
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var buttonSpin: UIButton!
    
    @IBOutlet weak var labelResult: UILabel!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func buttonSpinTouchUpInside(_ sender: Any) {
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 2, animated: true)
        
        
        print(dataArray1[pickerView.selectedRow(inComponent: 0)])
        print(dataArray1[pickerView.selectedRow(inComponent: 1)])
        print(dataArray1[pickerView.selectedRow(inComponent: 2)])
        
        
        if(dataArray1[pickerView.selectedRow(inComponent: 0)] == dataArray2[pickerView.selectedRow(inComponent: 1)] &&
            dataArray2[pickerView.selectedRow(inComponent: 1)] == dataArray3[pickerView.selectedRow(inComponent: 2)]) {
            
            labelResult.text = "Bingo!!";
        } else {
            labelResult.text = ""
        }
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
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        //imageArray = ["🍎","😍","🐮","🐼","🐔","🎅","🚍","💖","👑","👻"]
        
//        imageArray = ["🍎","😍","🐮","🐼","🍎","😍","🐮","🐼"]
        
        imageArray = ["A","B","C","D"]
        
        let count = UInt32(imageArray.count )
        
        for _ in 0 ..< rowCount  {
            dataArray1.append((Int)(arc4random() % count ))
            dataArray2.append((Int)(arc4random() % count ))
            dataArray3.append((Int)(arc4random() % count ))
        }
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
}

//==============================//
// MARK:      UIPickerView Delegate
//=============================//

extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if component == 1 {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
}

//==============================//
// MARK:      UIPickerView DataSource
//=============================//

extension ViewController : UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowCount
    }

}










