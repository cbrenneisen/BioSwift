//
//  BioSequence+Hashable.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 9/14/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
     The hash value of the sequence
     */
    var hashValue: Int {
        return sequenceString.hashValue
    }
    
    /**
     Compare two sequences
     */
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.sequenceString == rhs.sequenceString
    }
}
 
