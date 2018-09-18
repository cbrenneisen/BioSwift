//
//  MendelianTestCase.swift
//  MendelianSwiftTests
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

class MendelianTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        InjectionMap.set(fileReader: TestSequenceFileReader())
        InjectionMap.set(debugMode: true)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     Asserts that the string representation of the sequence is found in the list
     - parameter needle: The sequence to seach for
     - parameter haystack: The list of possible matches for the sequence
     */
    func XCTAssert<T: BioSequence>(_ needle: T, existsIn haystack: String...){
        XCTAssert(needle.sequenceString, existsIn: haystack)
    }
    
    /**
     Asserts that an object is found in the given list
     - parameter needle: The item to seach for
     - parameter haystack: The list of possible matches for the item
     */
    func XCTAssert<T: Equatable>(_ needle: T, existsIn haystack: T...){
        XCTAssert(needle, existsIn: haystack)
    }
    
    /**
     Asserts that an object is found in the given list
     - parameter needle: The item to seach for
     - parameter haystack: The list of possible matches for the item
     */
    private func XCTAssert<T: Equatable>(_ needle: T, existsIn haystack: [T]){
        var found = false
        for item in haystack {
            if needle == item {
                found = true
                break
            }
        }
        
        XCTAssertTrue(found, "Needle must exist in the haystack")
    }
}
