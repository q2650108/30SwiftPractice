//
//  MyCollectionVCell.swift
//  Project 24 - MosaicLayout
//
//  Created by SHUN on 1/16/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MyCollectionVCell: UICollectionViewCell {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var imageViewContent: UIImageView!
 
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
