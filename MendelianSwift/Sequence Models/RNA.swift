//
//  RNA.swift
//  BioSwift
//
//  Created by Carl Brenneisen on 01/22/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.

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
     Get the codon at the specified index - returns nil if there are not enough bases at this location
     - parameter index: the starting index of the first base of the codon
     */
    func codon(at index: Int) -> Codon? {
        guard index <= length - 3 else { return nil }
        return (self[index], self[index+1], self[index+2])
    }
    
    /**
     Get the codon at the specified index - no checks for out of bounds
     - parameter index: the starting index of the first base of the codon
    */
    internal func codon(unsafeAt index: Int) -> Codon {
        return (self[index], self[index+1], self[index+2])
    }
    
    /**
     The current sequence as a sequence of codons
    */
    var codons: [Codon] {
        return stride(from: 0, to: length, by: 3).map(){
            return codon(unsafeAt: $0)
        }
    }
    
    /**
        Translates the RNA into a Protein object
    */
    func translate() -> Protein {
        
        var seq: [AminoAcid] = []
        for n in stride(from: 0, to: length, by: 3){
            guard let aa = AminoAcid(from: self.codon(unsafeAt: n)) else {
                // - STOP Codon found
                break
            }
            
            seq.append(aa)
        }
        return Protein(id: id, sequence: seq)
    }
}
