//
//  DNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/21/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct DNA: BioSequence {

    public var sequence: String
    public var id: String?
    
    public init?(sequence: String){
        
        let valid = DNA.validCharacters()
        for n in sequence {
            if !(valid.contains(n)){
                return nil
            }
        }
        self.sequence = sequence
    }
    
    //valid nucleobases are A, C, G, T
    public static func validCharacters()-> Set<Character> {
        return Set("ACGT")
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
    public static func hammingDistance(between dna1: DNA, and dna2: DNA) -> Int? {
        return dna1.hammingDistance(of: dna2)
    }
}

//MARK: - Instance Properties and Functions
public extension DNA {
    
    /**
        Computes and returns the gc content of the DNA
    */
    public var gcContent: Float {
        var occurrences = 0
        sequence.forEach() {
            switch $0 {
            case "G", "C":
                occurrences += 1
            default:
                break
            }
        }
        return ((Float(occurrences) / Float(sequence.count))*100.0)
    }
    
    /**
     Returns the count of all bases in the DNA object
     */
    public var baseCount: [Base: Int] {
        return sequence.reduce(into: [Base: Int]()){
            $0[Base(unsafeFrom: $1), default: 0] += 1
        }
    }
    
    /**
        Creates a new RNA object by transcribing the DNA
    */
    public func transcribe() -> RNA {
        let seq = String(sequence.map{ $0 != "T" ? $0 : "U" })
        // - RNA is guaranteed to be valid - okay to force unrwrap
        return RNA(sequence: seq)!
    }
    
    /**
        Creates and returns the reverse complement of the DNA
    */
    public func reverseComplement() -> DNA {
        
        let seq = sequence.reversed().compactMap{ x in
            DNA.complements[x]
        }.joined(separator: "")
        
        //guarenteed to work, so force unwrapping is fine
        return DNA(sequence: seq)!
    }

    
    /**
        Returns the Hamming Distance between this and another DNA
    */
    public func hammingDistance(of otherDNA: DNA) -> Int? {
        
        guard length == otherDNA.length else {
            print("Attempting to get the hamming distance between two DNA of unequal length")
            return nil
        }
        
        // - count the number of bases that are different between both sequences
        var difference = 0
        zip(sequence, otherDNA.sequence).forEach() {
            if $0 != $1 {
                difference += 1
            }
        }
        return 0
    }
}
