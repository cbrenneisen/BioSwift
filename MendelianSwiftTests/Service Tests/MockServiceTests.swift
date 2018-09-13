//
//  MockServiceTests.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 3/9/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class MockServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: DNA
    
    /**
     Test that the correct number of DNA is generated
     */
    func testCounts(){
        let dna1 = [DNA].random(min: 50, max: 70, count: -1)
        let dna2 = [DNA].random(min: 50, max: 70, count: 0)
        let dna3 = [DNA].random(min: 50, max: 70, count: 1)
        let dna4 = [DNA].random(min: 50, max: 70, count: 10)
        
        XCTAssertTrue(dna1.isEmpty, "Count cannot be negative")
        XCTAssertTrue(dna2.isEmpty, "Count was 0")
        XCTAssertEqual(dna3.count, 1, "Count should 1")
        XCTAssertEqual(dna4.count, 10, "Count should be 10")
    }
    
    /**
     Test that negative min and maxes are not accepted
    */
    func testMinAndMaxNegatives() {
        // negatives
        let dna1 = [DNA].random(min: -1, max: 7, count: 10)
        let dna2 = [DNA].random(min: 30, max: -15, count: 10)
        let dna3 = [DNA].random(min: -99, max: -33, count: 10)
        
        // negatives
        XCTAssertTrue(dna1.isEmpty, "Negative numbers are not allowed")
        XCTAssertTrue(dna2.isEmpty, "Negative numbers are not allowed")
        XCTAssertTrue(dna3.isEmpty, "Negative numbers are not allowed")
    }
    
    /**
     Test that DNA of a specific length are properly generated
     */
    func testSpecificLength() {
        
        let length = 77
        let num = 100
        let dnaList = [DNA].random(min: length, max: length, count: num)
        
        // - test the total amount
        XCTAssertEqual(dnaList.count, num, "Did not generate the correct number of DNA")
        
        // - test each length
        dnaList.forEach() {
            XCTAssertEqual($0.length, length, "DNA should at least be \(length) bases long")
        }
    }
    
    /**
     Test that DNA of variable lengths are properly generated
     */
    func testVariableLength() {
        
        let min = 20
        let max = 30
        let num = 100
        let dnaList = [DNA].random(min: 20, max: 30, count: num)
        
        // - test the total amount
        XCTAssertEqual(dnaList.count, num, "Did not generate the correct number of DNA")
        
        // - test each length
        dnaList.forEach() {
            XCTAssertGreaterThanOrEqual($0.length, min, "DNA should at least be as long as \(min)")
            XCTAssertLessThanOrEqual($0.length, max, "DNA should not be longer than \(max)")
        }
    }
    
//    //MARK: RNA
//    func testRNAGeneration() {
//
//        let minL = 20
//        let maxL = 30
//        let num = 1000
//        let rnaSet = MockService.generateRandomRNA(minLength: minL, maxLength: maxL, count: num)
//        XCTAssertEqual(rnaSet.count, num, "Did not generate the correct number of RNA")
//
//        for rna in rnaSet {
//            XCTAssertTrue((rna.length >= minL && rna.length <= maxL),
//                          "Incorrect RNA length was generated")
//        }
//    }
//
//    func testRNAEdgeCases() {
//        //0 = DNA, 0 = RNA, 0 = Protein
//
//        let rnaSet1 = MockService.generateRandomRNA(minLength: -1, maxLength: 7, count: 10)
//        XCTAssertEqual(rnaSet1.count, 0, "Generation should not have run")
//
//        let rnaSet2 = MockService.generateRandomRNA(minLength: 100, maxLength: 70, count: 10)
//        XCTAssertEqual(rnaSet2.count, 0, "Generation should not have run")
//
//        let rnaSet3 = MockService.generateRandomRNA(minLength: 50, maxLength: 70, count: -1)
//        XCTAssertEqual(rnaSet3.count, 0, "Generation should not have run")
//
//        let rnaSet4 = MockService.generateRandomRNA(minLength: 50, maxLength: 70, count: 0)
//        XCTAssertEqual(rnaSet4.count, 0, "Generation should not have run")
//
//        let rnaSet5 = MockService.generateRandomRNA(minLength: 50, maxLength: 70, count: 1)
//        XCTAssertEqual(rnaSet5.count, 1, "Generation should have only created one RNA")
//
//        let controlledLength = 80
//        let rnaSet6 = MockService.generateRandomRNA(minLength: controlledLength,
//                                                    maxLength: controlledLength, count: 100)
//        XCTAssertEqual(rnaSet6.count, 100, "Generation should have created 100 RNA strands")
//
//        for rna in rnaSet6 {
//            XCTAssertEqual(rna.length, controlledLength, "Incorrect RNA length was generated")
//        }
//
//        //test that the min, middle, and max lengths all occur
//        var counts = (0,0,0)
//        let minL = 20
//        let maxL = minL + 2
//        let rnaSet7 = MockService.generateRandomRNA(minLength: minL,
//                                                    maxLength: maxL, count: 1000)
//        for rna in rnaSet7 {
//            XCTAssertTrue((rna.length >= minL && rna.length <= maxL),
//                          "Incorrect RNA length was generated")
//            switch(rna.length){
//                case minL:
//                    counts.0 += 1
//                    break
//                case maxL:
//                    counts.2 += 1
//                    break
//                default:
//                    counts.1 += 1
//            }
//        }
//
//        XCTAssertGreaterThan(counts.0, 0, "Min Length not encountered")
//        XCTAssertGreaterThan(counts.1, 0, "Middle Length not encountered")
//        XCTAssertGreaterThan(counts.2, 0, "Max Length not encountered")
//    }
//
//    //MARK: Protein
//    func testProteinGeneration() {
//
//        let minL = 20
//        let maxL = 30
//        let num = 1000
//        let proteinSet = MockService.generateRandomRNA(minLength: minL, maxLength: maxL, count: num)
//        XCTAssertEqual(proteinSet.count, num, "Did not generate the correct number of Protein")
//
//        for protein in proteinSet {
//            XCTAssertTrue((protein.length >= minL && protein.length <= maxL),
//                          "Incorrect Protein length was generated")
//        }
//    }
//
//    func testProteinEdgeCases() {
//        //0 = DNA, 0 = RNA, 0 = Protein
//
//        let proteinSet1 = MockService.generateRandomProtein(minLength: -1, maxLength: 7, count: 10)
//        XCTAssertEqual(proteinSet1.count, 0, "Generation should not have run")
//
//        let proteinSet2 = MockService.generateRandomProtein(minLength: 100, maxLength: 70, count: 10)
//        XCTAssertEqual(proteinSet2.count, 0, "Generation should not have run")
//
//        let proteinSet3 = MockService.generateRandomProtein(minLength: 50, maxLength: 70, count: -1)
//        XCTAssertEqual(proteinSet3.count, 0, "Generation should not have run")
//
//        let proteinSet4 = MockService.generateRandomProtein(minLength: 50, maxLength: 70, count: 0)
//        XCTAssertEqual(proteinSet4.count, 0, "Generation should not have run")
//
//        let proteinSet5 = MockService.generateRandomProtein(minLength: 50, maxLength: 70, count: 1)
//        XCTAssertEqual(proteinSet5.count, 1, "Generation should have only created one Protein")
//
//        let controlledLength = 80
//        let proteinSet6 = MockService.generateRandomRNA(minLength: controlledLength,
//                                                    maxLength: controlledLength, count: 100)
//        XCTAssertEqual(proteinSet6.count, 100, "Generation should have created 100 Protein strands")
//
//        for protein in proteinSet6 {
//            XCTAssertEqual(protein.length, controlledLength, "Incorrect Protein length was generated")
//        }
//
//        //test that the min, middle, and max lengths all occur
//        var counts = (0,0,0)
//        let minL = 20
//        let maxL = minL + 2
//        let proteinSet7 = MockService.generateRandomProtein(minLength: minL,
//                                                            maxLength: maxL, count: 1000)
//        for protein in proteinSet7 {
//            XCTAssertTrue((protein.length >= minL && protein.length <= maxL),
//                          "Incorrect Protein length was generated")
//            switch(protein.length){
//                case minL:
//                    counts.0 += 1
//                    break
//                case maxL:
//                    counts.2 += 1
//                    break
//                default:
//                    counts.1 += 1
//            }
//        }
//
//        XCTAssertGreaterThan(counts.0, 0, "Min Length not encountered")
//        XCTAssertGreaterThan(counts.1, 0, "Middle Length not encountered")
//        XCTAssertGreaterThan(counts.2, 0, "Max Length not encountered")
//    }
//
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
