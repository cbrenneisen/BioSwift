//
//  DNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/21/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct DNA {
    
    public let sequence: String
    public let id: String?
    
    public init(sequence: String){
        self.sequence = sequence
        id = nil
    }
    
    public init(sequence: String, id: String){
        
        self.sequence = sequence
        self.id = id
        
    }
    
    //returns a base at a given position
    public func getBase (i: Int) -> Character {
        let nIndex = sequence.index(sequence.startIndex, offsetBy: i)
        let n = sequence.characters[nIndex]
        return n
        
    }
    
    //returns the length of the DNA's sequence
    public var sequenceLength: Int {
        return self.sequence.characters.count
    }
    
    //returns whether or not the DNA's sequence is valid
    public lazy var valid: Bool = {
        
        let nucleotides = Set("ACGT".characters)
        let filteredSeq = String(self.sequence.characters.filter { nucleotides.contains($0) })
        if filteredSeq.characters.count != self.sequence.characters.count {
            //string was invalid because there were non valid characters entered
            return false
        }
        return true
    }()
    
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
