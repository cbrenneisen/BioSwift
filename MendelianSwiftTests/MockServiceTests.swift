//
//  MockServiceTests.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 3/9/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

class MockServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDNAGeneration() {
        
        let minL = 20
        let maxL = 30
        let num = 1000
        let dnaSet = MockService.generateRandomDNA(minLength: minL, maxLength: maxL, count: num)
        XCTAssertEqual(dnaSet.count, num, "Did not generate the correct number of DNA")
        
        for dna in dnaSet {
            XCTAssertTrue((dna.sequenceLength >= minL && dna.sequenceLength <= maxL),
                          "Incorrect DNA length was generated")
        }
    }
    
    func testDNAEdgeCases() {
        
        let dnaSet1 = MockService.generateRandomDNA(minLength: -1, maxLength: 7, count: 10)
        XCTAssertEqual(dnaSet1.count, 0, "Generation should not have run")
        
        let dnaSet2 = MockService.generateRandomDNA(minLength: 100, maxLength: 70, count: 10)
        XCTAssertEqual(dnaSet2.count, 0, "Generation should not have run")

        let dnaSet3 = MockService.generateRandomDNA(minLength: 50, maxLength: 70, count: -1)
        XCTAssertEqual(dnaSet3.count, 0, "Generation should not have run")
        
        let dnaSet4 = MockService.generateRandomDNA(minLength: 50, maxLength: 70, count: 0)
        XCTAssertEqual(dnaSet4.count, 0, "Generation should not have run")

        let dnaSet5 = MockService.generateRandomDNA(minLength: 50, maxLength: 70, count: 1)
        XCTAssertEqual(dnaSet5.count, 1, "Generation should have only created one DNA")
        
        let controlledLength = 80
        let dnaSet6 = MockService.generateRandomDNA(minLength: controlledLength,
                                                    maxLength: controlledLength, count: 100)
        XCTAssertEqual(dnaSet6.count, 100, "Generation should have created 100 DNA strands")
        
        for dna in dnaSet6 {
            
            XCTAssertEqual(dna.sequenceLength, controlledLength, "Incorrect DNA length was generated")
            print(dna.sequence)
        }
        
        //test that the min, middle, and max lengths all occur
        var counts = (0,0,0)
        let minL = 20
        let maxL = minL + 2
        let dnaSet7 = MockService.generateRandomDNA(minLength: minL,
                                                    maxLength: maxL, count: 1000)
        for dna in dnaSet7 {
            XCTAssertTrue((dna.sequenceLength >= minL && dna.sequenceLength <= maxL),
                          "Incorrect DNA length was generated")
            switch(dna.sequenceLength){
                case minL:
                    counts.0 += 1
                    break
                case maxL:
                    counts.2 += 1
                    break
                default:
                    counts.1 += 1
            }
        }

        XCTAssertGreaterThan(counts.0, 0, "Min Length not encountered")
        XCTAssertGreaterThan(counts.1, 0, "Middle Length not encountered")
        XCTAssertGreaterThan(counts.2, 0, "Max Length not encountered")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
