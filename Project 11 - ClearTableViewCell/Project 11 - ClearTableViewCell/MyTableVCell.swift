//
//  MyTableVCell.swift
//  Project 11 - ClearTableViewCell
//
//  Created by SHUN on 11/25/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class MyTableVCell: UITableViewCell {

    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
      let gradientLayer = CAGradientLayer()
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
     // MARK:     Layout Property
    //=============================//
    
    
    @IBOutlet weak var labelTitle: UILabel!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("TableViewCell")
        
        gradientLayer.frame = self.bounds
        let color1 = UIColor.whiteColor().colorWithAlphaComponent(0)
        let color2 = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        let color3 = UIColor.clearColor().CGColor
        let color4 = UIColor.blackColor().colorWithAlphaComponent(1)
        
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.04, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, atIndex: 0)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews: \(self.bounds)")
        gradientLayer.frame = self.bounds
    }
    
    deinit{
        print("\(self.dynamicType) deinit")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    


}
