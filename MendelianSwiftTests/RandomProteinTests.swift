//
//  RandomProteinTests.swift
//  MendelianSwiftTests
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class RandomProteinTests: MendelianTestCase {
    
    /**
     Test that the correct number of Protein is generated
     */
    func testCounts(){
        let Protein1 = [Protein].random(min: 50, max: 70, count: -1)
        let Protein2 = [Protein].random(min: 50, max: 70, count: 0)
        let Protein3 = [Protein].random(min: 50, max: 70, count: 1)
        let Protein4 = [Protein].random(min: 50, max: 70, count: 10)
        
        XCTAssertTrue(Protein1.isEmpty, "Count cannot be negative")
        XCTAssertTrue(Protein2.isEmpty, "Count was 0")
        XCTAssertEqual(Protein3.count, 1, "Count should 1")
        XCTAssertEqual(Protein4.count, 10, "Count should be 10")
    }
    
    /**
     Test that negative min and maxes are not accepted
     */
    func testMinAndMaxNegatives() {
        // negatives
        let Protein1 = [Protein].random(min: -1, max: 7, count: 10)
        let Protein2 = [Protein].random(min: 30, max: -15, count: 10)
        let Protein3 = [Protein].random(min: -99, max: -33, count: 10)
        
        // negatives
        XCTAssertTrue(Protein1.isEmpty, "Negative numbers are not allowed")
        XCTAssertTrue(Protein2.isEmpty, "Negative numbers are not allowed")
        XCTAssertTrue(Protein3.isEmpty, "Negative numbers are not allowed")
    }
    
    /**
     Test that Protein of a specific length are properly generated
     */
    func testSpecificLength() {
        
        let length = 77
        let num = 100
        let ProteinList = [Protein].random(min: length, max: length, count: num)
        
        // - test the total amount
        XCTAssertEqual(ProteinList.count, num, "Did not generate the correct number of Protein")
        
        // - test each length
        ProteinList.forEach() {
            XCTAssertEqual($0.length, length, "Protein should at least be \(length) bases long")
        }
    }
    
    /**
     Test that Protein of variable lengths are properly generated
     */
    func testVariableLength() {
        
        let min = 20
        let max = 30
        let num = 100
        let ProteinList = [Protein].random(min: 20, max: 30, count: num)
        
        // - test the total amount
        XCTAssertEqual(ProteinList.count, num, "Did not generate the correct number of Protein")
        
        // - test each length
        ProteinList.forEach() {
            XCTAssertGreaterThanOrEqual($0.length, min, "Protein should at least be as long as \(min)")
            XCTAssertLessThanOrEqual($0.length, max, "Protein should not be longer than \(max)")
        }
    }
}
