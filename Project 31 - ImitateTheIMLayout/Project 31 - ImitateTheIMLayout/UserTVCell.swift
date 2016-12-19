//
//  UserTVCell.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/12/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class UserTVCell: UITableViewCell {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    @IBOutlet weak var imageViewProfileUser: UIImageView!
    
    @IBOutlet weak var labelUserSingle: UILabelPadding!

    @IBOutlet weak var labelUserMulti: UILabel!
    
    @IBOutlet weak var labelUserBackground: UILabel!
    
    @IBOutlet weak var labelUserTime: UILabel!
    
    
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
        
        // Configure the view for the selected state
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
