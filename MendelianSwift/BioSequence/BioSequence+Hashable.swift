//
//  BioSequence+Hashable.swift
//  MendelianSwift
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
     The hash value of the sequence
     */
    public var hashValue: Int {
        return sequenceString.hashValue
    }
    
    /**
     Compare two sequences
     */
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.sequenceString == rhs.sequenceString
    }
}
 
