//
//  APIWikiFaceParser.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation
import UIKit

class APIWikiFaceParser  {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var valueDic: [String : AnyObject]?
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    init( dic : [String : AnyObject] ) {
        valueDic = dic
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
    
    func parse() -> WikiFaceEntity? {
        
        guard let dic = valueDic else {
            return nil
        }
        
        if let query = dic["query"] as? NSDictionary {
            if let pages = query["pages"] as? NSDictionary {
                if let pageContent = pages.allValues.first as? NSDictionary {
                    if let thumbnail = pageContent["thumbnail"] as? NSDictionary {
                        if let thumbURL = thumbnail["source"] as? String {
                            return WikiFaceEntity(urlString: thumbURL)
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
}

