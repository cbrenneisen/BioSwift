//
//  Array+Test.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 9/17/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation
import XCTest
@testable import MendelianSwift

extension Array where Element: BioSequence {
    
    /**
     Read mock sequences with the given FASTA file name
     Will fail if the file is in an invalid format
     - parameter file: the file to read from
     - parameter ext: the file extension
     - parameter expected: the expected number of sequences
     */
    static func test(fasta: String, ext: String = "txt", expected: Int? = nil) -> [Element] {
        let sequences = Element.from(fasta: fasta)
        if let exp = expected {
            XCTAssertEqual(sequences.count, exp, "Did not read all sequences")
        }
        return sequences
    }
}
