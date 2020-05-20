//
//  DNAMotifTests.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 11/12/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class DnaMotifTests: MendelianTestCase {

    func testMotifs(){
        let baseDNA = DNA.test("GATATATGCATATACTT")
        let subDNA = DNA.test("ATAT")
        
        let motifs = baseDNA.motifs(of: subDNA)
        
        XCTAssertEqual(motifs, [1, 3, 9])
    }
    
    func testSplicedMotifsEasy(){
        verifyMotif(from: "dna-motifs1", indices: [2, 7, 9])
    }
    
    func testSplicedMotifsHard(){
        verifyMotif(
            from: "dna-motifs3",
            indices: [0, 2, 4, 7, 11, 20, 27, 36, 37, 42, 46, 47, 48, 54, 57,
                      62, 68, 69, 70, 74, 75, 77, 78, 79, 83, 85, 86, 91, 105,
                      106, 108, 117, 122, 123, 125, 129, 135, 136, 140])
    }
    
    private func verifyMotif(from file: String, indices: [Int]){
        let dna = [DNA].test(fasta: file)
        XCTAssertGreaterThanOrEqual(dna.count, 2, "There must be enough data to test")

        guard let result = dna[0].splicedMotif(of: dna[1]) else {
            XCTFail("There should be a spliced motif")
            return
        }
        
        print(result.map{ String($0) }.joined(separator: " "))
        XCTAssertEqual(result, indices)
    }

}
