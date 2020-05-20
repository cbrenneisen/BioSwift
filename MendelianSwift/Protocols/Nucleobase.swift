//
//  Nucleobase.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 8/29/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public protocol Nucleobase: Hashable, CaseIterable {
    
    init?(from char: Character)
}

public extension Nucleobase {
    
    /**
     Raw string representation of the Nucleobase
    */
    var string: String {
        return String(describing: self)
    }
    
    /**
     An array containing one of each possible base
    */
    static var all: [Self] {
        return Self.allCases.map{ $0 }
    }
        
    /**
     Creates a Nucleobase from a one-letter string
    */
    init?(from letter: String) {
        // - only strings of length one should be accepted
        guard letter.count == 1, let base = letter.first else {
            return nil
        }
        
        self.init(from: base)
    }
    
    /**
     Creates a sequence from the given string
    */
    static func sequence(from string: String) -> [Self]?{
        var sequence: [Self] = []
        
        // - try to create bases for each character in the string
        for char in string.uppercased() {
            guard let base = Self(from: char) else {
                print("Invalid character \(char) passed for creation of base \(String(describing: Self.self))")
                return nil
            }
            sequence.append(base)
        }
        return sequence
    }
    
    /**
     Initialize an empty dictionary to begin counting bases
    */
    static var counts: [Self: Int] {
        return Self.allCases.reduce(into: [Self: Int]()){
            $0[$1] = 0
        }
    }
}

internal extension Nucleobase {
    
    /**
     Creates a Nucleobase from a character with no validation checks
    */
    init(unsafeFrom char: Character){
        self.init(from: char)!
    }
}
