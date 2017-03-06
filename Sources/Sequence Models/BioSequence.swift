//
//  BioSequence.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public class BioSequence {
    
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
    
    //returns the length of the Protein's sequence
    public var sequenceLength: Int {
        return self.sequence.characters.count
    }
    
    //returns a base at a given position
    public func getBase (index: Int) -> Character {
        let nIndex = sequence.index(sequence.startIndex, offsetBy: index)
        let n = sequence.characters[nIndex]
        return n
    }
    
    //returns all valid characters - primarily used for validation function
    internal func validSequenceCharacters() -> Set<Character> {
        return Set("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)
    }
    
    //use this to ensure that a sequence is valid
    public lazy var valid: Bool = {
        
        let validChars = self.validSequenceCharacters()
        for n in self.sequence.characters {
            if !validChars.contains(n){
                //invalid character
                return false
            }
        }
        //no invalid characters found
        return true
    }()
}
