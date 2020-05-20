//
//  DNA.swift
//  BioSwift
//
//  Created by Carl Brenneisen on 01/21/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.

import Foundation

public struct DNA: BioSequence {
    
    public var sequence: [DNA.Base]
    public var id: String?
    
    /**
     Create a new DNA object
     - parameter id: the identifier of the sequence
     - parameter sequence: a series of valid nucleobases that make up the sequence
     */
    public init(id: String?, sequence: [Base]){
        self.sequence = sequence
        self.id = id
    }
}

//NARK: - Static Properties and Functions

public extension DNA {
    
    /**
        A map containing the complement of each nucleobase
     */
    internal static var complements: [Character: String] {
        return ["A": "T", "T": "A", "G": "C", "C": "G"]
    }

    /**
        Returns the Hamming Distance between two DNA objects
     */
    static func hammingDistance(between dna1: DNA, and dna2: DNA) -> Int? {
        return dna1.hammingDistance(of: dna2)
    }
}

//MARK: - Instance Properties and Functions
public extension DNA {
    
    /**
        Computes and returns the gc content of the DNA
    */
    var gcContent: Float {
        var occurrences = 0
        sequence.forEach() {
            switch $0 {
            case .G, .C:
                occurrences += 1
            default:
                break
            }
        }
        return ((Float(occurrences) / Float(length))*100.0)
    }
    
    /**
        Creates a new RNA object by transcribing the DNA
    */
    func transcribe() -> RNA {
        let seq = sequence.map{ $0.transcribed }
        return RNA(id: id, sequence: seq)
    }
    
    /**
        Creates and returns the reverse complement of the DNA
    */
    func reverseComplement() -> DNA {
        print(sequenceString)
        let seq = sequence.reversed().map{ $0.complement }
        return DNA(id: id, sequence: seq)
    }

    /**
        Returns the Hamming Distance between this and another DNA
    */
    func hammingDistance(of otherDNA: DNA) -> Int? {
        
        guard length == otherDNA.length else {
            print("Attempting to get the hamming distance between two DNA of unequal length")
            return nil
        }
        
        // - count the number of bases that are different between both sequences
        var difference = 0
        zip(sequenceString, otherDNA.sequenceString).forEach() {
            if $0 != $1 {
                difference += 1
            }
        }
        return 0
    }
    
    /**
        Create a protein object by transcribing and translating its exons
        - parameter introns: The subsequences to remove before transcribing and translating
     */
    func splice(with introns: [[DNA.Base]]) -> Protein? {
        
        var exons = sequence
        introns.forEach(){ intron in
            if let index = exons.index(of: intron){
                exons.removeSubrange(index..<intron.count)
            }
        }
        
        return DNA(sequence: exons).transcribe().translate()
    }
}
