//
//  MockServiceTests.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 3/9/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class RandomDNATests: MendelianTestCase {
        
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
}
