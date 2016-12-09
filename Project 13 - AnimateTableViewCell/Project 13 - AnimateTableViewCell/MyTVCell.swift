//
//  MyTVCell.swift
//  Project 13 - AnimateTableViewCell
//
//  Created by SHUN on 12/8/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class MyTVCell: UITableViewCell {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var labelContent: UILabel!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init(style: UITableViewCellStyle, reuseIdentifier: String?)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init?(coder aDecoder: NSCoder)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("awakeFromNib")
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
