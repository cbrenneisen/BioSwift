//
//  Nucleobase.swift
//  MendelianSwift
//
//  Created by mac on 8/29/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public protocol Nucleobase: Hashable {
    
    init?(from char: Character)
    static var all: [Self] { get }
}

//TODO: add case iterable in Swift 4.2
public extension Nucleobase {
    
    public var string: String {
        return String(describing: self)
    }
        
    /**
     Creates a Nucleobase from a one-letter string
    */
    public init?(from letter: String) {
        // - only strings of length one should be accepted
        guard letter.count == 1, let base = letter.first else {
            return nil
        }
        
        self.init(from: base)
    }
    
    /**
     Creates a sequence from the given string
    */
    public static func sequence(from string: String) -> [Self]?{
        var sequence: [Self] = []
        
        // - try to create bases for each character in the string
        for char in string {
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
    public static var counts: [Self: Int] {
        return Self.all.reduce(into: [Self: Int]()){
            $0[$1] = 0
        }
    }
}

internal extension Nucleobase {
    
    /**
     Creates a Nucleobase from a character with no validation checks
    */
    internal init(unsafeFrom char: Character){
        self.init(from: char)!
    }
}
