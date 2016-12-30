//
//  Int+ degreesToRadians.swift
//  Project 16 - SlideMenu
//
//  Created by SHUN on 12/29/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import Foundation

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
