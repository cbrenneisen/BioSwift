//
//  BioSequence.swift
//  BioSwift
//
//  Created by Carl Brenneisen on 01/30/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.

import Foundation

public protocol BioSequence: Hashable, SequenceFileReaderInjected {

    associatedtype Base: Nucleobase
    
    var sequence: [Base] { get }
    var sequenceString: String { get }
    
    var id: String? { get set }

    init(id: String?, sequence: [Base])
}

public extension BioSequence {
    
    /**
     Create a new sequence object
     - parameter sequence: a series of valid elements that make up the sequence
     */
    init(sequence: [Base]) {
        self.init(id: nil, sequence: sequence)
    }
    
    //MARK: - Failable
    
    /**
     Create a sequence from a raw string. Returns nil if the string is invalid
     - parameter id: the idenfitifer of the sequence
     - parameter sequence: the series of characters representing the sequence
     */
    init?(id: String?, sequence: String) {
        
        guard let seq = Base.sequence(from: sequence) else {
            print("Could not create sequence from base")
            return nil
        }
        
        self.init(id: id, sequence: seq)
    }
    
    /**
     Create a sequence from a raw string. Returns nil if the string is invalid
     - parameter sequence: the series of characters representing the sequence
     */
    init?(sequence: String){
        self.init(id: nil, sequence: sequence)
    }
    
    /**
     Create a sequence from a raw text file
     - parameter contentsOfFile: The path of the file
     */
    init?(contentsOfFile file: String){
        guard let string = Self.fileReader.string(from: file) else{
            print("Error creating sequence from file \(file)")
            return nil
        }
        
        self.init(id: nil, sequence: string)
    }
}
