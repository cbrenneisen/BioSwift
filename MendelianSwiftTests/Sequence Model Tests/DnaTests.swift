//
//  DnaTests.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 3/5/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class DnaTests: MendelianTestCase {
    
    func testTranscribe(){
        let dna = DNA.test("GATGGAACTTGACTACGTAAATT")
        let rna = dna.transcribe()
        
        XCTAssertEqual(rna.sequenceString, "GAUGGAACUUGACUACGUAAAUU", "DNA was not transcribed properly")
    }
    
    func testReverseComplement(){
        
        let dna = DNA.test("AAAACCCGGT")
        let dna2 = dna.reverseComplement()
        
        XCTAssertEqual(dna2.sequenceString, "ACCGGGTTTT", "DNA was not transcribed properly")
    }

        
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
        
    func testConsensus(){
        let allDNA = [DNA].test(fasta: "fasta3", ext: "txt", expected: 7)
        
        guard let consensus = allDNA.getConsensusSequence() else {
            XCTFail("Could not get consensus string")
            return
        }
        
        XCTAssertEqual(consensus.sequenceString, "ATGCAACT")
    }
    
    func testLongestSharedMotif(){
        let allDNA = [DNA].test(fasta: "fasta4", ext: "txt", expected: 3)
        
        guard let shared = allDNA.longestSharedMotif else {
            XCTFail("Could not find a shared motif")
            return
        }
        
        XCTAssert(shared, existsIn: "AC", "CA", "TA")
    }

}
