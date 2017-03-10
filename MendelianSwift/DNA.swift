//
//  DNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/21/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct DNA: BioSequence, Equatable, Hashable {
    
    public var sequence: String
    public var id: String?
    
    public init?(sequence: String){
        
        let valid = DNA.validCharacters()
        for n in sequence.characters {
            if !(valid.contains(n)){
                return nil
            }
        }
        self.sequence = sequence
    }
    
    //valid nucleobases are A, C, G, T
    public static func validCharacters()-> Set<Character> {
        return Set("ACGT".characters)
    }
    
    public static func == (lhs: DNA, rhs: DNA) -> Bool {
        return lhs.sequence == rhs.sequence
    }

    public var hashValue: Int {
        return self.sequence.hashValue
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
