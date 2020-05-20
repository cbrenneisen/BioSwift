//
//  BioSequence+Addition.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 10/22/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
    Add the arrays of two sequence objects to create a new sequence
    Any existing identifier is lost
    */
    static func + (left: Self, right: Self) -> Self {
        return Self(sequence: left.sequence + right.sequence)
    }
    
    /**
     Appends the second sequence's array to the first sequence
     Keep the identifier of the first sequence
    */
    static func += (left: inout Self, right: Self) {
        left = Self(id: left.id, sequence: left.sequence + right.sequence)
    }
}
