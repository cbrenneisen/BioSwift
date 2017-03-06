//
//  Protein.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct Protein: BioSequence {
    
    public var sequence: String
    public var id: String? 
    
    //valid characters are A-Z except B,J,O,U,X,Z
    public func validCharacters()-> Set<Character> {
        return Set("ACDEFGHIKLMNPQRSTVWY".characters)
    }

}
