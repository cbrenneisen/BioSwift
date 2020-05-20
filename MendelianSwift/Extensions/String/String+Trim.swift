//
//  String+Trim.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 9/12/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

internal extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
