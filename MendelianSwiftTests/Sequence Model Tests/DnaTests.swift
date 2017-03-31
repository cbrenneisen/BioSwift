//
//  DnaTests.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 3/5/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

class DnaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    //test that valid sequences result in a DNA object and that invalid ones do not
    func testInit() {
        
        if let _ = DNA(sequence: "ACGGGUA"),
           let _ = DNA(sequence: "TTT9dnzW"),
           let _ = DNA(sequence: "ACDEFGHIKLMNPQRSTVWY") {
            XCTFail("Invalid Sequences accepted")
        }
        
        guard let _ = DNA(sequence: "ATCCAGCT"),
              let _ = DNA(sequence: "ATCCAGCT"),
              let _ = DNA(sequence: "ATGGATCT"),
              let _ = DNA(sequence: "AAGCAACC"),
              let _ = DNA(sequence: "TTGGAACT"),
              let _ = DNA(sequence: "ATGCCATT"),
              let _ = DNA(sequence: "ATGCCATT") else {
                XCTFail("Did not accept valid sequences")
                return
        }
    }
    
    func testEquality(){

        guard let dnaA1 = DNA(sequence: "ATCCAGCT"),
              let dnaA2 = DNA(sequence: "ATCCAGCT"),
              let dnaB1 = DNA(sequence: "ATGCCATT"),
              let dnaB2 = DNA(sequence: "ATGCCATT") else {
                
            XCTFail("Did not accept valid sequences")
            return
        }
        XCTAssertEqual(dnaA1, dnaA2, "These strands should be equal")
        XCTAssertEqual(dnaB1, dnaB1, "These strands should be equal")
        
        XCTAssertNotEqual(dnaA1, dnaB1, "These strands should NOT be equal")
        XCTAssertNotEqual(dnaA2, dnaB2, "These strands should NOT be equal")
        XCTAssertNotEqual(dnaA1, dnaB2, "These strands should NOT be equal")
        XCTAssertNotEqual(dnaA2, dnaB1, "These strands should NOT be equal")
    }
    
    //test equality via randomly generated strands of DNA
    func testEqualityRandom(){
        
        let allDNA = MockService.generateRandomDNA(minLength: 20, maxLength: 20, count: 20)
        
        for dna in allDNA {
            
            //test duplicate dna
            guard let copyDNA = DNA(sequence: dna.sequence) else {
                XCTFail("This should not happen")
                return
            }
            XCTAssertEqual(dna, copyDNA, "These strands should be equal")

            let reversedSeq = String(dna.sequence.characters.reversed())
            
            //skip if the strand is miraculously the same from front to back
            if reversedSeq == dna.sequence {
                continue
            }
            
            guard let reverseDNA = DNA(sequence: reversedSeq) else {
                XCTFail("This should not happen")
                return
            }
            
            XCTAssertNotEqual(dna, reverseDNA, "These strands should not be equal")
        }
    }
    
    func testHash(){
        let allDNA = MockService.generateRandomDNA(minLength: 20, maxLength: 20, count: 20)
        
        for dna in allDNA {
            
            XCTAssertEqual(dna.hashValue, dna.sequence.hashValue, "Hash value should be equal to sequence hash value")
        }
    }
    
    func testGCContent(){
        let seq = "CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTT" +
                  "CAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT"
        guard var dna = DNA(sequence: seq) else {
                XCTFail("Did not accept valid sequences")
                return
        }
        
        XCTAssertEqual(dna.gcContent, 60.919540, "GC Content not computed correctly")
        XCTAssertEqualWithAccuracy(dna.gcContent, 60.919540, accuracy: 0.000005)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
