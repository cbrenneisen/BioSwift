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
    var hashValue: Int { get }

    //this function needs to validate the given sequence
    init?(sequence: String)
    
    //needs to return valid characters for the given type (i.e: DNA returns A, C, G, T)
    static func validCharacters()-> Set<Character>
    
}

//default implementations
extension BioSequence {
    
    public init?(id: String, sequence: String){
        self.init(sequence: sequence)
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
}
