//
//  DNA+InitTests.swift
//  MendelianSwiftTests
//
//  Created by mac on 9/11/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class DNA_InitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     Test that invalid strings do not result in valid DNA objects
     */
    func testInvalidInit() {
        if let _ = DNA(sequence: "ACGGGUA"),
            let _ = DNA(sequence: "TTT9dnzW"),
            let _ = DNA(sequence: "ACDEFGHIKLMNPQRSTVWY") {
            XCTFail("Invalid Sequences accepted")
        }
    }
    
    /**
     Test that valid strings can be used to create DNA objects
     */
    func testValidInit(){
        guard
            let _ = DNA(sequence: "ATCCAGCT"),
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
    
    func testFileInit(){
        guard let dna = DNA(contentsOfFile: "dna1") else {
            XCTFail("Did not accept valid sequences")
            return
        }
        XCTAssertEqual(dna.sequenceString, "d")
    }
}
