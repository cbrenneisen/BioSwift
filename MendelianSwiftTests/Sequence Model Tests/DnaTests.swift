//
//  DnaTests.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 3/5/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class DnaTests: MendelianTestCase {
        
    func testGCContent(){
        let seq = "CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTT" +
                  "CAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT"
        guard let dna = DNA(sequence: seq) else {
            XCTFail("Did not accept valid sequences")
            return
        }
        
        XCTAssertEqual(dna.gcContent, 60.919540, "GC Content not computed correctly")
        XCTAssertEqual(dna.gcContent, 60.919540, accuracy: 0.000005)
    }
    
    func testMotifs(){
        let baseDNA = DNA.test("GATATATGCATATACTT")
        let subDNA = DNA.test("ATAT")
        
        let motifs = baseDNA.motifs(of: subDNA)
        
        XCTAssertEqual(motifs, [1, 3, 9])
    }
    
    func testConsensus(){
        let allDNA = [DNA].test(fasta: "fasta3", ext: "txt", expected: 7)
        
        guard let consensus = allDNA.getConsensusSequence() else {
            XCTFail("Could not get consensus string")
            return
        }
        
        XCTAssertEqual(consensus.sequenceString, "ATGCAACT")
    }
}
