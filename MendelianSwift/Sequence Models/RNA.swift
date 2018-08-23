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
    
    public static func == (lhs: RNA, rhs: RNA) -> Bool {
        return lhs.sequence == rhs.sequence
    }
    
    public var hashValue: Int {
        return self.sequence.hashValue
    }
    
    //return the codon starting at the given index
    public func codonFrom(index: Int) -> String? {
        
        //error handling
        if index > sequenceLength - 3 || index < 0{
            return nil
        }
        
        let startIndex = self.sequence.index(self.sequence.startIndex, offsetBy: index)
        let endIndex = self.sequence.index(self.sequence.startIndex, offsetBy: index + 3)
        
        return String(self.sequence[startIndex..<endIndex])
    }
}
