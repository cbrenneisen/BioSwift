//
//  FileReader.swift
//  MendelianSwift
//
//  Created by mac on 9/12/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

protocol SequenceFileReader {
    
    var bundle: Bundle { get }
}

internal extension SequenceFileReader {
    
    /**
     Returns the raw (trimmed) text for a given file using the file reader's bundle
     - parameter file: the name of the file
     - parameter type: the file extension
     */
    func string(from file: String, type: String = "txt") -> String? {
        // - get the path of the file
        guard let path = path(for: file, type: type) else { return nil }
        
        // - get the text of the file
        guard let string = String(fromFile: path)?.trimmed else{
            print("Could not read text from file '\(file)' with extension '\(type)'")
            return nil
        }
        return string
    }
    
    /**
     Returns an array of strings corresponding to the FASTA format
     An ID string will begin with '>' and contain the ID
     Each preceding string will contain the next part of the current sequence until another id is found
     - parameter file: the name of the file
     - parameter type: the file extension
    */
    func fastaStrings(from file: String, type: String = "txt") -> [String] {
        // - get the path of the file
        guard let path = path(for: file, type: type) else { return [] }

        // - get the strings of the file
        guard let strings = String(fromFile: path)?.components(separatedBy: .newlines) else{
            print("Could not read text from file '\(file)' with extension '\(type)'")
            return []
        }
        return strings
    }
    
    /**
     Returns the path for a given file using the file reader's bundle
     - parameter file: the name of the file
     - parameter type: the file extension
    */
    private func path(for file: String, type: String) -> String? {
        guard let path = bundle.path(forResource: file, ofType: type) else {
            print("File '\(file)' with extension '\(type)' does not exist")
            return nil
        }
        return path
    }
}

