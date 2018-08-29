//
//  Nucleobase.swift
//  MendelianSwift
//
//  Created by mac on 8/29/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public protocol Nucleobase {
    
    init?(from char: Character)
    static var all: [Self] { get }
}

//TODO: add case iterable in Swift 4.2
public extension Nucleobase {
    
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
}

internal extension Nucleobase {
    
    /**
     Creates a Nucleobase from a character with no validation checks
    */
    internal init(unsafeFrom char: Character){
        self.init(from: char)!
    }
}
