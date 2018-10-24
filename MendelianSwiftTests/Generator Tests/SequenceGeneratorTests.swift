//
//  SequenceGeneratorTests.swift
//  MendelianSwiftTests
//
//  Created by mac on 10/23/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class SequenceGeneratorTests: MendelianTestCase {
    
    /**
     Test that we can get all permutations of pure text
     */
    func testPermutationsRaw1(){
        let alphabet = "ACGT"

        let all = SequenceGenerator.permutations(of: alphabet, length: 2)
        XCTAssertEqual(all.count, 16)
    }
    
    /**
      Test that we can get all permutations of pure text
     */
    func testPermutationsRaw2(){
        let alphabet = "ABCDEFGHIJ"
        
        let all = SequenceGenerator.permutations(of: alphabet, length: 2)
        XCTAssertEqual(all.count, 100)
    }
    
    /**
      Test that we can get all permutations of DNA
     */
    func testPermutationsDNA(){
        let all = DNA.permutations(length: 2)
        
        XCTAssertEqual(all.count, 16)
    }
}
