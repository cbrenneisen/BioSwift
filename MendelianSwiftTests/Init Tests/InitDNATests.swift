//
//  DNA+InitTests.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 9/11/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class InitDNATests: MendelianTestCase {
    
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
    
    /**
     Test that valid files can be used to create DNA objects
    */
    func testFileInit(){
        guard let dna = DNA(contentsOfFile: "dna1") else {
            XCTFail("Did not accept valid sequences")
            return
        }
        
        XCTAssertEqual(dna.length, 947, "Sequence should be read in its entirety")
    }
    
    /**
     Test that fasta files can be used to create DNA objects
    */
    func testFastaInit(){
        let dna = DNA.from(fasta: "fasta1")
        XCTAssertEqual(dna.count, 10, "All sequences should be read")
    }

}
