//
//  String+Trim.swift
//  MendelianSwift
//
//  Created by mac on 9/12/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

internal extension String {
    
    internal var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
