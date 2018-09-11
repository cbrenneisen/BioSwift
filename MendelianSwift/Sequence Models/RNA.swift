//
//  RNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct RNA: BioSequence  {
    
    public var sequence: [Base]
    public var id: String?
    
    /**
     Create a new RNA object
     - parameter id: the identifier of the sequence
     - parameter sequence: a series of valid nucleobases that make up the sequence
     */
    public init(id: String?, sequence: [Base]){
        self.sequence = sequence
        self.id = id
    }

    //return the codon starting at the given index
    public func codonFrom(index: Int) -> String? {
        
        //error handling
        if index > length - 3 || index < 0 {
            return nil
        }
        
        let startIndex = self.sequenceString.index(self.sequenceString.startIndex, offsetBy: index)
        let endIndex = self.sequenceString.index(self.sequenceString.startIndex, offsetBy: index + 3)
        
        return String(self.sequenceString[startIndex..<endIndex])
    }

}

//MARK: - Instance Properties and Functions
public extension RNA {
    
    /**
     Creates a new Protein object by translating the RNA
     */
    public func transcribe() -> RNA {
        let seq = String(sequenceString.map{ $0 != "T" ? $0 : "U" })
        // - RNA is guaranteed to be valid - okay to force unrwrap
        return RNA(sequence: seq)!
    }
    
    /**
        Get the codon at the specified index - no checks for out of bounds
    */
    internal func codonUnsafe(at index: Int) -> String {
        let startIndex = sequenceString.index(self.sequenceString.startIndex, offsetBy: index)
        let endIndex = sequenceString.index(self.sequenceString.startIndex, offsetBy: index + 3)
        return String(sequenceString[startIndex..<endIndex])
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
