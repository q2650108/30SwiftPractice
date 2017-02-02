//
//  APIProtocol.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation

protocol APIProtocol {
    
    weak var delegate : APIDelegate? { get set }
    
    func start()
}
