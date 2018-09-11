//
//  DnaTests.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 3/5/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class DnaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
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
    
    func testGCContent(){
        let seq = "CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTT" +
                  "CAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT"
        guard let dna = DNA(sequence: seq) else {
                XCTFail("Did not accept valid sequences")
                return
        }
        
        XCTAssertEqual(dna.gcContent, 60.919540, "GC Content not computed correctly")
        XCTAssertEqual(dna.gcContent, 60.919540, accuracy: 0.000005)
    }
}
