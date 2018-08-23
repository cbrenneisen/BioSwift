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
        return self.sequence.count
    }
    
    //returns a base at a given position
    public func getBase (index: Int) -> Character {
        let nIndex = sequence.index(sequence.startIndex, offsetBy: index)
        let n = sequence[nIndex]
        return n
    }
    
    //returns the subsequence starting with 'start' and ending with (and including) 'end'
    public func getSubSequence(start: Int, end: Int) -> String {
        let range = Range(start...end)
        let startIndex = index(from: range.lowerBound)
        let endIndex = index(from: range.upperBound)
        return String(self.sequence[startIndex..<endIndex])
    }

    //helper function for the above
    private func index(from: Int) -> String.Index {
        return self.sequence.index(self.sequence.startIndex, offsetBy: from)
    }

}
