//
//  BioSequence+Subscript.swift
//  MendelianSwift
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
     Returns the base at the given position
     - parameter index: the position of the desired base
     */
    public subscript (index: Int) -> Base {
        return sequence[index]
    }
    
    /**
     Returns the bases at the specified range
     - parameter range: the range specifying the desired indices
     */
    public subscript (range: CountableRange<Int>) -> [Base] {
        return Array(sequence[range.lowerBound..<range.upperBound])
    }
}
