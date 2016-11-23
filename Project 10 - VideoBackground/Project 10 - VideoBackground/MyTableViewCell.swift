//
//  MyTableViewCell.swift
//  Project 10 - VideoBackground
//
//  Created by SHUN on 11/21/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    //==============================//
    // MARK:     Layout Property
    //=============================//
    @IBOutlet weak var imageViewPreview: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
