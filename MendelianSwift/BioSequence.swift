//
//  BioSequence.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

protocol BioSeq {
    var sequence: String { get set }

    func validCharacters()-> Set<Character>
}

extension BioSeq {
    
    public init?(sequence: String){
        self.init(sequence: sequence)
        self.sequence = sequence
        
        let valid = self.validCharacters()
        for n in sequence.characters {
            if !(valid.contains(n)){
                return nil
            }
        }
    }
    
    //returns the length of the sequence
    public var sequenceLength: Int {
        return self.sequence.characters.count
    }
    
    //returns a base at a given position
    public func getBase (index: Int) -> Character {
        let nIndex = sequence.index(sequence.startIndex, offsetBy: index)
        let n = sequence.characters[nIndex]
        return n
    }

//    //use this to ensure that a sequence is valid
//    public func isValid() -> Bool  {
//        
//        let validChars = type(of: self).validCharacters()
//        for n in self.sequence.characters {
//            if !validChars.contains(n){
//                //invalid character
//                return false
//            }
//        }
//        //no invalid characters found
//        return true
//    }
}

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
    
    //returns the length of the sequence
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

extension BioSequence: Equatable, Hashable{
    
    public static func == (lhs: BioSequence, rhs: BioSequence) -> Bool {
        return lhs.sequence == rhs.sequence
    }
    
    public var hashValue: Int {
        return self.sequence.hashValue
    }

}
