//
//  DNAFragmentTests.swift
//  MendelianSwiftTests
//
//  Created by mac on 10/22/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class FragmentDNATests: MendelianTestCase {
    
    /**
     Test that we can get the super sequence of a small dataset
    */
    func testFragmentsEasy1(){
        
        let allDNA = [DNA].test(fasta: "dna-fragments1")
        
        guard let seq = allDNA.assembleFragments() else {
            XCTFail("No super sequence was found")
            return
        }
        
        XCTAssertEqual(seq.sequenceString, "GCTAAGTTCATGCATC", "Found wrong super sequence")
    }
    
    /**
     Test that we can get the super sequence of a small dataset
     */
    func testFragmentsEasy2(){
        
        let allDNA = [DNA].test(fasta: "dna-fragments2")
        
        guard let seq = allDNA.assembleFragments() else {
            XCTFail("No super sequence was found")
            return
        }
        
        XCTAssertEqual(seq.sequenceString, "ATTAGACCTGCCGGAATAC", "Found wrong super sequence")
    }
    
    /**
     Test that we can get the super sequence of a large dataset
    */
    func testFragmentsHard(){
        
        let allDNA = [DNA].test(fasta: "dna-fragments3")
        let answer = DNA.test(file: "dna-fragments3-answer")
        
        guard let seq = allDNA.assembleFragments() else {
            XCTFail("No super sequence was found")
            return
        }
        
        XCTAssertEqual(seq, answer, "Found wrong super sequence")
    }
}
