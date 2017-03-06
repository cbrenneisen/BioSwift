//
//  BioServiceTests.swift
//  MendelianSwiftTests
//
//  Created by Carlos Brenneisen on 3/4/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

class BioServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNucleobaseCount() {

        guard let dna = DNA(sequence: "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC") else {
            XCTFail("Invalid DNA sequence")
            return
        }
        
        let result = BioService.nucleobaseCount(dna: dna)
        
        guard let a = result["A"],
              let c = result["C"],
              let g = result["G"],
              let t = result["T"] else {
                XCTFail("Result did not include count for all bases")
                return
        }
    
        XCTAssertEqual(a, 20, "Incorrect number of Adenine")
        XCTAssertEqual(c, 12, "Incorrect number of Cytosine")
        XCTAssertEqual(g, 17, "Incorrect number of Guanine")
        XCTAssertEqual(t, 21, "Incorrect number of Thymine")

    }
    
    func testTranscribe(){
        
        guard let dna = DNA(sequence: "GATGGAACTTGACTACGTAAATT") else {
            XCTFail("Invalid DNA sequence")
            return
        }
        
        let rna = BioService.transcribe(dna: dna)
        
        XCTAssertEqual(rna.sequence, "GAUGGAACUUGACUACGUAAAUU", "DNA was not transcribed properly")
    }
    
    func testReverseComplement(){

        guard let dna = DNA(sequence: "AAAACCCGGT") else {
            XCTFail("Invalid DNA sequence")
            return
        }
        
        let dna2 = BioService.reverseComplement(dna: dna)
        
        XCTAssertEqual(dna2.sequence, "ACCGGGTTTT", "DNA was not transcribed properly")
    }
    
    func testGCContent(){
        
//        let allDNA = FastaService.loadDNA(fastaFile: "fasta1")
//        let dna = BioService.highestGCContent(dnaSequences: allDNA)
//        if let d = dna {
//            print(d.id!)
//            print(d.gcContent)
//        }
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
