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
        
        let result = dna.baseCount
        
        guard let a = result[.A],
              let c = result[.C],
              let g = result[.G],
              let t = result[.T] else {
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
        
        let rna = dna.transcribe()
        
        XCTAssertEqual(rna.sequenceString, "GAUGGAACUUGACUACGUAAAUU", "DNA was not transcribed properly")
    }
    
    func testReverseComplement(){

        guard let dna = DNA(sequence: "AAAACCCGGT") else {
            XCTFail("Invalid DNA sequence")
            return
        }
        
        let dna2 = dna.reverseComplement()
        
        XCTAssertEqual(dna2.sequenceString, "ACCGGGTTTT", "DNA was not transcribed properly")
    }
    
//    func testOverlapGraph(){
//        
//        guard let dna1 = DNA(sequence: "AAATAAA"),
//              let dna2 = DNA(sequence: "AAATTTT"),
//              let dna3 = DNA(sequence: "TTTTCCC"),
//              let dna4 = DNA(sequence: "AAATCCC"),
//              let dna5 = DNA(sequence: "GGGTGGG") else{
//                XCTFail("Invalid DNA sequence")
//                return
//        }
//        
//        let allDNA = [dna1, dna2, dna3, dna4, dna5]
//        let graph = BioService.overlapGraph(allDNA: allDNA, threshold: 3)
//        let edges = graph.getAllEdges()
//        XCTAssertEqual(edges.count, 3, "Wrong number of edges were created")
//        
//        let exists1 = graph.edgeExists(fromSequence: dna1, toSequence: dna2)
//        let exists2 = graph.edgeExists(fromSequence: dna1, toSequence: dna4)
//        let exists3 = graph.edgeExists(fromSequence: dna2, toSequence: dna3)
//        XCTAssertTrue(exists1, "There should be an edge from dna1 to dna2")
//        XCTAssertTrue(exists2, "There should be an edge from dna1 to dna4")
//        XCTAssertTrue(exists3, "There should be an edge from dna2 to dna3")
//
//        
//    }
    
    func testSplice(){
        /*
        let seq = "ATGGTCTACATAGCTGACAAACAGCACGTAGCAATCGGTCGAATCTCGAGAGGCAT" +
                  "ATGGTCACATGATCGGTCGAGCGTGTTTCAAAGTTTGCGCCTAG"
        guard let subjectDNA = DNA(sequence: seq) else {
            XCTFail("Invalid DNA sequence")
            return
        }
        let introns = ["ATCGGTCGAA", "ATCGGTCGAGCGTGT"]
        
        guard let protein = BioService.splice(dna: subjectDNA, introns: introns) else {
            XCTFail("Method call failed")
            return
        }
        print(protein.sequence)*/
        
        let seq = "ATGCTAATTCGAGGTGACTTGACAAACTGCCCCTACCAGAGTCCCATAACATGTTTCCCT" +
        "CGGGCGACACGGGTAACGGCGCTTCGGCACGTAAGGATAAATTTCTATACGCGATAATAT" +
        "CGAGAGTAACTCGTATTTGCTCCGGCGCAACTAGGACACAACTTCGCGTAGCAACTCGCA" +
        "TGTGAGTAGCTTTTGAGAGGTTGGACATGTGTTCGAAGTGCATGACTCGGTTATTGACAG" +
        "CGCTTATTATATCATGGTGGCGCGTAGCAGTTTCGCCACTCTCGAGGCGGGCCGAGCCCA" +
        "ATCCTTTTCTTGCGGATCGTCATTGCCTGCCTGCGCCTCGATATCTGGCATGGAAAGGTG" +
        "AATCACCAGGCTCGCCATGCCGCGTTGAAGAGTTTGCCGCAGCATGCAATTACCCGTGAT" +
        "CGGGCGACACCGCGGAATTAGAGTATTTGGCATTATTTACCCGCAGCGGATGATTTGGTT" +
        "GTGGCCCGGTCGAATTAATATCACCAGGTTGTTCCAAAATGCCTTAGGCATGGACGCACT" +
        "TAAATCGTTTACTCCAGCCCGGTACACTAATTGCTCGGCAACCATGAACAAGTGAATACC" +
        "GTTGCTTGCCGAGTGAACGCTACGAGGCCTTCACACATCTTCCACTCTATGAACTCTATT" +
        "GCCGACTGATACGGCACCCTGCGGGTTATGAGCGCCGGTGTTGTTGCAATACTGTTATGT" +
        "TTCTCCCGTAGTGCTACCAAACAAGGGGCAGTTCTGCCGACTTTCGCGGTCCTGTAAGCA" +
        "CGTTTACACGCTAAGTCGTCTAAGAGCGAAGCCACGGGCAAATGACTCTCAAGAACCCGA" +
        "GCGTTCAACTGCGCACATTTGTCTTCGTTAATCGGAAGTTTGTTACGTTACGAAGAGTAA" +
        "GCCACAGGGTATCGTTCGCGCGTGTAACAATCGTGGCTTTGGTTAG"
        guard let subjectDNA = DNA(sequence: seq) else {
            XCTFail("Invalid DNA sequence")
            return
        }
        let introns = ["TTGTTACGTTACGAAGAGTAAGCCACAGGGTATCGTTCGCGCG", "TGTTGCAATACTGTTATGTTTCTCCCGTAGTGCTACCAAAC",
                       "GGAAAGGTGAA", "CAACTGCGCACAT", "ACTCGCATGTGAGTAGCTTTTGAGAGGTT",
                       "TATACGCGATAATATCGAGAGTAACTCGTATT", "TACCAGAGTCCCATAACATGTTTCCCT", "TGATCGGGCGACACCGCGGA",
                       "ATCATGGTGGCGCGTAGCAGTTTCGCCACTCTCGAGGCGGG", "CGGCAACCATGAA", "ATTAATATCACCAGGTTGTTCCAAAATGCCTTAGGCATGGACG", "TCACACATCTTCCACTCTATGAACTCTATTGCCGACTGATACGGCAC", "TACACGCTAAGTCGTCTAAGAG"]
        
        guard let protein = BioService.splice(dna: subjectDNA, introns: introns) else {
            XCTFail("Method call failed")
            return
        }
        print(protein.sequence)
        
        //TODO: add assertion here 
    }
    
    func testslicedMotif(){
        
        guard let dna = DNA(sequence: "ACGTACGTGACG"), let motif = DNA(sequence: "GTA") else {
            return
        }
        
        guard let indices = BioService.splicedMotif(dna: dna, motif: motif) else {
            return
        }
        
        print(indices)
        
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
