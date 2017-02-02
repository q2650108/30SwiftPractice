//
//  APIDelegate.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation

@objc protocol APIDelegate  {
    
    @objc optional func APIWikiFace( returnCode : APIEnum , message : String , returnData : WikiFaceEntity? )
    
}
