//
//  BioSequenceTests.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 3/31/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

class BioSequenceTests: XCTestCase {
    
    /* This test file is for testing default implementations (extension) */
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    //test that the sequence length function works
    //via inference, we only need to test this for one type of sequence
    func testSequenceLength() {
        
        var minL = 30
        var maxL = minL
        
        let allDNA1 = MockService.generateRandomDNA(minLength: minL, maxLength: maxL, count: 10)
        for dna in allDNA1 {
            XCTAssertEqual(dna.sequenceLength, minL, "Sequence length should return \(minL)")
        }
        
        minL = 20
        maxL = 40
        let allDNA2 = MockService.generateRandomDNA(minLength: minL, maxLength: maxL, count: 10)
        for dna in allDNA2 {
            XCTAssertGreaterThanOrEqual(dna.sequenceLength, minL,
                "Sequence length should return at least \(minL)")
            XCTAssertLessThanOrEqual(dna.sequenceLength, maxL,
                "Sequence length should return no more than \(maxL)")
        }
    }
    
    //test getting a base at a specified index
    func testGetBase(){
        
        //test when we have a strand of 1 base
        var minL = 1
        var maxL = minL
        
        let allDNA1 = MockService.generateRandomDNA(minLength: minL, maxLength: maxL, count: 10)
        for dna in allDNA1 {
            
            //get the only base
            let base = String(dna.getBase(index: 0))
            
            XCTAssertEqual(base, dna.sequence, "Getting the base should result in the entire sequence")
        }
        
        //test getting every single base in a longer sequence
        minL = 20
        maxL = 40
        
        let allDNA2 = MockService.generateRandomDNA(minLength: minL, maxLength: maxL, count: 10)
        for dna in allDNA2 {
            
            var mirrorSeq = ""
            for i in 0...dna.sequenceLength-1 {
                let base = String(dna.getBase(index: i))
                mirrorSeq += base
            }
            XCTAssertEqual(mirrorSeq, dna.sequence, "Should have been able to get every individual base")
        }
    }
    
    //test getting a subsequence of a sequence
    func testGetSubsequence(){
        
        //generate one dna for testing
        let minL = 20
        let maxL = 40
        
        let allDNA = MockService.generateRandomDNA(minLength: minL, maxLength: maxL, count: 10)

        for dna in allDNA {
            //test getting every single possible subsequence
            for left in 0...dna.sequenceLength - 1 {
                var mirrorSeq = ""
                for right in left...dna.sequenceLength - 1 {
                    
                    //build the corresponding sequence manually - getBase is already tested
                    let base = String(dna.getBase(index: right))
                    mirrorSeq += base
                    
                    let subSequence = dna.getSubSequence(start: left, end: right)
                    
                    XCTAssertEqual(subSequence, mirrorSeq,
                                   "Subsequence should be equal to the manually re-created corresponding sequence")
                }
            }
        }
    }

    
}
