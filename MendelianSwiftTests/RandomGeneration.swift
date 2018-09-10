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
        validate(min: min, max: max, count: count)
        return (0..<count).map{ _ in
            return Element.random(min: min, max: max)
        }
    }
    
    private static func validate(min: Int, max: Int, count: Int){
        if min > max || min < 0 || max < 0 || count < 0 {
            //TODO: elaborate
            fatalError("Invalid argument")
        }
    }
}

extension BioSequence {
    
    /**
        Generate a random sequence
        - parameter min: the guaranteed minimum length (inclusive)
        - parameter max: the guaranteed maximum length (inclusive)
    */
    static func random(min: Int, max: Int) -> Self {
        validate(min: min, max: max)
        
        let randomLength = Int(arc4random_uniform(UInt32((maxLength-minLength) + 1))) + minLength
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
    private static func validate(min: Int, max: Int){
        if min > max || min < 0 || max < 0 {
            //TODO: elaborate
            fatalError("Invalid argument")
        }
    }
}
