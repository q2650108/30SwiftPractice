//
//  String+localized.swift
//  Project 06 - Get user's current location
//
//  Created by SHUN on 10/31/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        //🖕Fuck the translators team, they don’t deserve comments
        return NSLocalizedString(self, comment: "Error")
    }
}