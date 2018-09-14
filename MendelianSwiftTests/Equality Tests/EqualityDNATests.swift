//
//  EqualityDNATests.swift
//  MendelianSwiftTests
//
//  Created by Carlos Brenneisen on 9/14/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class EqualityDNATests: MendelianTestCase {
    
    /**
     Test that two equivalent sequences are seen as equal
     */
    func testEquality(){
        guard let dnaA1 = DNA(sequence: "ATCCAGCT"),
            let dnaA2 = DNA(sequence: "ATCCAGCT"),
            let dnaB1 = DNA(sequence: "ATGCCATT"),
            let dnaB2 = DNA(sequence: "ATGCCATT") else {
                
                XCTFail("Did not accept valid sequences")
                return
        }
        
        XCTAssertEqual(dnaA1, dnaA2, "Equality Function does not work")
        XCTAssertEqual(dnaB1, dnaB2, "Equality Function does not work")
    }
    
    /**
     Test that non-equivalent sequences are not seen as equal
     */
    func testInequality(){
        guard let dnaA1 = DNA(sequence: "ATCCAGCT"),
            let dnaA2 = DNA(sequence: "ATCCAGCT"),
            let dnaB1 = DNA(sequence: "ATGCCATT"),
            let dnaB2 = DNA(sequence: "ATGCCATT") else {
                
                XCTFail("Did not accept valid sequences")
                return
        }
        
        XCTAssertNotEqual(dnaA1, dnaB1, "Equality Function does not work")
        XCTAssertNotEqual(dnaA2, dnaB2, "Equality Function does not work")
        XCTAssertNotEqual(dnaA1, dnaB2, "Equality Function does not work")
        XCTAssertNotEqual(dnaA2, dnaB1, "Equality Function does not work")
    }

}
