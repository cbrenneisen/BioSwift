//
//  DNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/21/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public class DNA: BioSequence {
    
    //valid nucleotides are A, C, G, T
    override internal func validSequenceCharacters() -> Set<Character> {
        return Set("ACGT".characters)
    }
    
    //returns the gc content of the DNA
    public lazy var gcContent: Float = {
        var occurrences = 0
        for n in self.sequence.characters {
            switch String(n) {
                case "G", "C":
                    occurrences += 1
                default:
                    continue
            }
        }
        
        return ((Float(occurrences) / Float(self.sequence.characters.count))*100.0)
    }()
}

public struct mnDNA: BioSeq, Equatable, Hashable {
    
    var sequence: String
    
    public init?(sequence: String){
        self.sequence = sequence
        
        let valid = self.validCharacters()
        for n in sequence.characters {
            if !(valid.contains(n)){
                return nil
            }
        }
    }

    
    public func validCharacters()-> Set<Character> {
        return Set("ACGT".characters)
    }
    
    public static func == (lhs: mnDNA, rhs: mnDNA) -> Bool {
        return lhs.sequence == rhs.sequence
    }

    public var hashValue: Int {
        return self.sequence.hashValue
    }
}
