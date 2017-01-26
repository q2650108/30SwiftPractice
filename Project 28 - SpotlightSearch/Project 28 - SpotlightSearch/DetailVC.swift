//
//  DetailVC.swift
//  Project 28 - SpotlightSearch
//
//  Created by SHUN on 1/26/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var data : [String : String]?
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    @IBOutlet weak var imageViewHeader: UIImageView!
    
    @IBOutlet weak var imageViewTitle: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelCategory: UILabel!
    
    @IBOutlet weak var labelRating: UILabel!
    
    @IBOutlet weak var labelDirector: UILabel!
    
    @IBOutlet weak var labelStars: UILabel!
    
    @IBOutlet weak var labelDesc: UILabel!
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = data else {
            return
        }
        
        imageViewBackground.image = UIImage(named: item["Image"]!)
        imageViewHeader.image = UIImage(named: item["Image"]!)
        imageViewTitle.image = UIImage(named: item["Image"]!)
        
        labelTitle.text = item["Title"] ?? ""
        labelCategory.text = item["Category"] ?? ""
        labelRating.text = "\(item["Rating"] ?? "") / 10"
        labelDirector.text = item["Director"] ?? ""
        labelStars.text = item["Stars"] ?? ""
         labelDesc.text = item["Description"] ?? ""
        
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
    
    func setData(  list : [String : String]){
        self.data = list
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
