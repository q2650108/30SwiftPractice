//
//  DetailTVCell.swift
//  Project 32 - Folding Cell
//
//  Created by SHUN on 2/22/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class DetailTVCell: UITableViewCell {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet var viewBackground : UIView!
    
    @IBOutlet var labelContent : UILabel!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
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
    
    
}
