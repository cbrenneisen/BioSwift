//
//  RNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public class RNA: BioSequence {
    
    //valid nucleotides are A, C, G, U
    override internal func validSequenceCharacters() -> Set<Character> {
        return Set("ACGU".characters)
    }
    
    //return the codon starting at the given index
    public func codonFrom(index:Int) -> String {
        
        let startIndex = self.sequence.index(self.sequence.startIndex, offsetBy: index)
        let endIndex = self.sequence.index(self.sequence.startIndex, offsetBy: index + 3)
        
        return self.sequence[startIndex..<endIndex]
    }
}
