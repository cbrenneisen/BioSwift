//
//  RandomRNATests.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 9/14/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class RandomRNATests: MendelianTestCase {
    
    /**
     Test that the correct number of RNA is generated
     */
    func testCounts(){
        let RNA1 = [RNA].random(min: 50, max: 70, count: -1)
        let RNA2 = [RNA].random(min: 50, max: 70, count: 0)
        let RNA3 = [RNA].random(min: 50, max: 70, count: 1)
        let RNA4 = [RNA].random(min: 50, max: 70, count: 10)
        
        XCTAssertTrue(RNA1.isEmpty, "Count cannot be negative")
        XCTAssertTrue(RNA2.isEmpty, "Count was 0")
        XCTAssertEqual(RNA3.count, 1, "Count should 1")
        XCTAssertEqual(RNA4.count, 10, "Count should be 10")
    }
    
    /**
     Test that negative min and maxes are not accepted
     */
    func testMinAndMaxNegatives() {
        // negatives
        let RNA1 = [RNA].random(min: -1, max: 7, count: 10)
        let RNA2 = [RNA].random(min: 30, max: -15, count: 10)
        let RNA3 = [RNA].random(min: -99, max: -33, count: 10)
        
        // negatives
        XCTAssertTrue(RNA1.isEmpty, "Negative numbers are not allowed")
        XCTAssertTrue(RNA2.isEmpty, "Negative numbers are not allowed")
        XCTAssertTrue(RNA3.isEmpty, "Negative numbers are not allowed")
    }
    
    /**
     Test that RNA of a specific length are properly generated
     */
    func testSpecificLength() {
        
        let length = 77
        let num = 100
        let RNAList = [RNA].random(min: length, max: length, count: num)
        
        // - test the total amount
        XCTAssertEqual(RNAList.count, num, "Did not generate the correct number of RNA")
        
        // - test each length
        RNAList.forEach() {
            XCTAssertEqual($0.length, length, "RNA should at least be \(length) bases long")
        }
    }
    
    /**
     Test that RNA of variable lengths are properly generated
     */
    func testVariableLength() {
        
        let min = 20
        let max = 30
        let num = 100
        let RNAList = [RNA].random(min: 20, max: 30, count: num)
        
        // - test the total amount
        XCTAssertEqual(RNAList.count, num, "Did not generate the correct number of RNA")
        
        // - test each length
        RNAList.forEach() {
            XCTAssertGreaterThanOrEqual($0.length, min, "RNA should at least be as long as \(min)")
            XCTAssertLessThanOrEqual($0.length, max, "RNA should not be longer than \(max)")
        }
    }
}
