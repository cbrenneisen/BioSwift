//
//  BioSequence+Fasta.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 9/14/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
     Create an array of sequence objects from the text of a FASTA file
     - parameter file: the complete path to the file
     */
    static func from(fasta file: String) -> [Self] {
        
        let lines = Self.fileReader.fastaStrings(from: file)
        
        var allSequences: [Self] = []
        var currentID = ""
        var currentSeq = ""
        
        lines.forEach {
            process(line: $0, &currentID, &currentSeq, all: &allSequences)
        }
        // - add the last line
        add(id: currentID, seq: currentSeq, to: &allSequences)
        
        return allSequences
    }
    
    /**
     Process a line of text in a FASTA file
     - parameter line: the complete line
     - parameter id: the last ID that has been found
     - parameter seq: the complete string representation of the current sequence
     - parameter array: the current array of all sequences found so far
     */
    private static func process(line: String, _ id: inout String, _ seq: inout String, all: inout [Self]){
        switch line.prefix(1){
        case ">":
            handleNewID(line, &id, &seq, all: &all)
        default:
            seq += line
        }
    }
    
    /**
     Handle the case when an ID is found in the text file
     - parameter line: the complete line, including the ID
     - parameter id: the last ID that has been found
     - parameter seq: the complete string representation of the preceding sequence
     - parameter array: the current array of all sequences found so far
     */
    private static func handleNewID(_ line: String, _ id: inout String, _ seq: inout String, all: inout [Self]){
        // - add previous sequence
        add(id: id, seq: seq, to: &all)
        
        // - reset sequence and set id
        seq = ""
        id = String(line.suffix(line.count-1))
    }
    
    /**
     Add the given sequence and id to the array of sequences.
     This checks to ensure that all parameters are valid before doing so
     - parameter id: the id of the sequence
     - parameter seq: the string representation of the sequence
     - parameter array: the array to add the sequence to
    */
    private static func add(id: String, seq: String, to array: inout [Self]){
        if !id.isEmpty && !seq.isEmpty {
            if let seq = Self(id: id, sequence: seq) {
                array.append(seq)
            }
        }
    }
}

