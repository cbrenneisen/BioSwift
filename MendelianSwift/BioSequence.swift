//
//  BioSequence.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

//required implementations
public protocol BioSequence {
    var sequence: String { get set }
    var id: String? { get set }

    func validCharacters()-> Set<Character>
}

//default implementations
extension BioSequence {
    
    public init?(sequence: String, id: String){
        
        self.init(sequence: sequence)
        self.id = id
    }
    
    public init?(sequence: String){
        self.init(sequence: sequence)
        self.sequence = sequence
    
        //validate the input based on the required 'validCharacters' function
        let valid = self.validCharacters()
        for n in sequence.characters {
            if !(valid.contains(n)){
                return nil
            }
        }
        self.id = nil
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
}
