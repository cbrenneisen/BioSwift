//
//  RNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct RNA: BioSequence, Equatable, Hashable {
    
    public var sequence: String
    public var id: String?
    
    public init?(sequence: String){
        
        let valid = RNA.validCharacters()
        for n in sequence {
            if !(valid.contains(n)){
                return nil
            }
        }
        self.sequence = sequence
    }
    
    //valid nucleobases are A, C, G, U
    public static func validCharacters()-> Set<Character> {
        return Set("ACGU")
    }
            
    //return the codon starting at the given index
    public func codonFrom(index: Int) -> String? {
        
        //error handling
        if index > length - 3 || index < 0 {
            return nil
        }
        
        let startIndex = self.sequence.index(self.sequence.startIndex, offsetBy: index)
        let endIndex = self.sequence.index(self.sequence.startIndex, offsetBy: index + 3)
        
        return String(self.sequence[startIndex..<endIndex])
    }

}

//MARK: - Instance Properties and Functions
public extension RNA {
    
    /**
     Creates a new Protein object by translating the RNA
     */
    public func transcribe() -> RNA {
        let seq = String(sequence.map{ $0 != "T" ? $0 : "U" })
        // - RNA is guaranteed to be valid - okay to force unrwrap
        return RNA(sequence: seq)!
    }
    
    /**
        Get the codon at the specified index - no checks for out of bounds
    */
    internal func codonUnsafe(at index: Int) -> String {
        let startIndex = sequence.index(self.sequence.startIndex, offsetBy: index)
        let endIndex = sequence.index(self.sequence.startIndex, offsetBy: index + 3)
        return String(sequence[startIndex..<endIndex])
    }
    
    /**
        Returns an array of 3-Character strings representing the codons of the RNA
    */
    var codons: [String] {
        return stride(from: 0, to: length, by: 3).map(){
            return codonUnsafe(at: $0)
        }
    }
    
    /**
        Translates the RNA into a Protein object
    */
    func translate() -> Protein? {
        var proteinSequence = ""
        for n in stride(from: 0, to: length, by: 3){
            let codon = codonUnsafe(at: n)
            guard let aa = Codon.codonToAminoAcid(codon: codon) else {
                continue
            }
            if aa.uppercased() == "STOP" {
                return Protein(sequence: proteinSequence)
            }
            proteinSequence +=  aa
        }
        // - if no stop codon was found, sequence is invalid
        return nil
    }
    
    
}

