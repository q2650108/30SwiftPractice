//
//  WikiFaceEntity.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation
import UIKit


@objc class WikiFaceEntity : NSObject {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    

    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    internal var faceImage : UIImage?
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    init( urlString : String ) {
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                faceImage = UIImage(data: data)
            } catch {
                print(error.localizedDescription)
            }
        }
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
