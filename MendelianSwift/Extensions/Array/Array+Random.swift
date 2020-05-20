//
//  Array+Random.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 9/14/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public extension Array where Element: BioSequence{
    
    /**
     Create an array of randomly generated sequences
     - parameter min: guaranteed minimum length of each sequence (inclusive)
     - parameter max: guaranteed maximum length of each sequence (inclusive)
     - parameter count: number of sequences to generate
     */
    static func random(min: Int, max: Int, count: Int) -> [Element]{
        guard validate(min, max, count) else { return [] }
        
        return (0..<count).compactMap{ _ in
            return Element.random(min: min, max: max)
        }
    }
    
    /**
     Validate the min, max, and count arguments that are provided
     */
    private static func validate(_ min: Int, _ max: Int, _ count: Int) -> Bool {
        // - all of these must hold true
        return (min <= max && min > 0 && max > 0 && count > 0)
    }
}
