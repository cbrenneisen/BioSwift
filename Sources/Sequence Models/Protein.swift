//
//  Protein.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public class Protein: BioSequence {
    
    //valid characters are A-Z except B,J,O,U,X,Z
    override internal func validSequenceCharacters() -> Set<Character> {
        return Set("ACDEFGHIKLMNPQRSTVWY".characters)
    }
}
