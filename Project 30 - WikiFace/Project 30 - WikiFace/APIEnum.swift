//
//  APIEnum.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation

@objc enum APIEnum  : Int {
    case Success = 0
    
    case RequestError = 1
    case JSONSerializationError = 2
    case ParseJSONError = 3
}
