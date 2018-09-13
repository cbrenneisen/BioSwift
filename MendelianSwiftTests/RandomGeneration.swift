//
//  RandomGeneration.swift
//  MendelianSwiftTests
//
//  Created by mac on 8/29/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation
import XCTest
@testable import MendelianSwift

extension Array where Element: BioSequence{
    
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

extension BioSequence {
    
    /**
        Generate a random sequence
        - parameter min: the guaranteed minimum length (inclusive)
        - parameter max: the guaranteed maximum length (inclusive)
    */
    static func random(min: Int, max: Int) -> Self? {
        guard validate(min, max) else { return nil }
        
        let randomLength = Int(arc4random_uniform(UInt32((max-min) + 1))) + min
        let seq: [Self.Base] = (0..<randomLength).map { _ in
            //randomly grab characters from the given set and append them to the sequence
            let randomIndex = Int(arc4random_uniform(UInt32(Self.Base.all.count)))
            return Self.Base.all[randomIndex]
        }
        return Self(id: nil, sequence: seq)
    }
    
    /**
        Validate the min and max arguments that are provided
    */
    private static func validate(_ min: Int, _ max: Int) -> Bool {
        // - all of these must hold true
        return (min <= max && min > 0 && max > 0)
    }
}
