//
//  BioSequence+Test.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 9/17/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation
import XCTest
@testable import MendelianSwift

extension BioSequence {

    /**
     Create a mock sequence with the given string
     Will fail if given an invalid string
     - parameter sequence: the string representation of the sequence
    */
    static func test(_ sequence: String) -> Self {
        guard let seq = Self(sequence: sequence) else {
            XCTFail("Invalid Sequence given")
            fatalError()
        }
        return seq
    }
    
    /**
     Create a mock sequence with the given file name
     Will fail if the file is in an invalid format
     - parameter file: the file to read from
     - parameter ext: the file extension
     */
    static func test(file: String, ext: String = "txt") -> Self {
        guard let seq = Self(contentsOfFile: file) else {
            XCTFail("Invalid file format")
            fatalError()
        }
        return seq
    }
}
