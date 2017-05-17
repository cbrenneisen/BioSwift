//
//  CodonTableTests.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 5/17/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift


class CodonTableTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testCodonToAminoAcid(){
        
        // UUU -> F
        guard let aa1 = CodonTable.shared.codonToAminoAcid(codon: "UUU") else {
            
            XCTFail("codon not retrieved")
            return
        }
        XCTAssertEqual(aa1, "F", "Not translated correctly, got \(aa1)")

        // CUU -> L
        guard let aa2 = CodonTable.shared.codonToAminoAcid(codon: "CUU") else {
            
            XCTFail("codon not retrieved")
            return
        }
        XCTAssertEqual(aa2, "L", "Not translated correctly, got \(aa2)")

        // AUU -> I
        guard let aa3 = CodonTable.shared.codonToAminoAcid(codon: "AUU") else {
            
            XCTFail("codon not retrieved")
            return
        }
        XCTAssertEqual(aa3, "I", "Not translated correctly, got \(aa3)")
        
        // GUU -> V
        guard let aa4 = CodonTable.shared.codonToAminoAcid(codon: "GUU") else {
            
            XCTFail("codon not retrieved")
            return
        }
        XCTAssertEqual(aa4, "V", "Not translated correctly, got \(aa4)")

        // UUC -> F
        guard let aa5 = CodonTable.shared.codonToAminoAcid(codon: "UUC") else {
            
            XCTFail("codon not retrieved")
            return
        }
        XCTAssertEqual(aa5, "F", "Not translated correctly, got \(aa5)")
    }
    
    func testAminoAcidToCodons(){
        
        // F -> UUU, UUC
        guard let codons1 = CodonTable.shared.aminoAcidToCodons(aminoAcid: "F") else {
            
            XCTFail("codons not retrieved")
            return
        }
        XCTAssertTrue(codons1.contains("UUU"), "Not translated correctly, did not get codon UUU")
        XCTAssertTrue(codons1.contains("UUC"), "Not translated correctly, did not get codon UUU")

        // L -> CUU, CUC, UUA, CUA, UUG, CUG
        guard let codons2 = CodonTable.shared.aminoAcidToCodons(aminoAcid: "L") else {
            
            XCTFail("codons not retrieved")
            return
        }
        XCTAssertTrue(codons2.contains("CUU"), "Did not get codon CUU")
        XCTAssertTrue(codons2.contains("CUC"), "Did not get codon CUC")
        XCTAssertTrue(codons2.contains("UUA"), "Did not get codon UUA")
        XCTAssertTrue(codons2.contains("CUA"), "Did not get codon CUA")
        XCTAssertTrue(codons2.contains("UUG"), "Did not get codon UUG")
        XCTAssertTrue(codons2.contains("CUG"), "Did not get codon CUG")
        
        // I -> AUU, AUC, AUA
        guard let codons3 = CodonTable.shared.aminoAcidToCodons(aminoAcid: "I") else {
            
            XCTFail("codons not retrieved")
            return
        }
        XCTAssertTrue(codons3.contains("AUU"), "Did not get codon CUU")
        XCTAssertTrue(codons3.contains("AUC"), "Did not get codon CUC")
        XCTAssertTrue(codons3.contains("AUA"), "Did not get codon UUA")

        
    }
    
    
    
    
}
