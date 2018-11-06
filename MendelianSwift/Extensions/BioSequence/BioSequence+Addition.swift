//
//  BioSequence+Addition.swift
//  MendelianSwift
//
//  Created by mac on 10/22/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
    Add the arrays of two sequence objects to create a new sequence
    Any existing identifier is lost
    */
    public static func + (left: Self, right: Self) -> Self {
        return Self(sequence: left.sequence + right.sequence)
    }
    
    /**
     Appends the second sequence's array to the first sequence
     Keep the identifier of the first sequence
    */
    public static func += (left: inout Self, right: Self) {
        left = Self(id: left.id, sequence: left.sequence + right.sequence)
    }
}
