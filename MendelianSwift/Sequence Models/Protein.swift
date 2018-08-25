//
//  Protein.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct Protein: BioSequence, Equatable, Hashable {
    
    public var sequence: String
    public var id: String?
    
    public init?(sequence: String) {
        
        let valid = Protein.validCharacters()
        for n in sequence {
            if !(valid.contains(n)){
                return nil
            }
        }
        self.sequence = sequence
    }

    //valid characters are A-Z except B,J,O,U,X,Z
    public static func validCharacters()-> Set<Character> {
        return Set("ACDEFGHIKLMNPQRSTVWY")
    }        
}
