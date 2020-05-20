//
//  BaseCountDNATests.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 9/26/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class BaseCountDnaTests: MendelianTestCase {
    
    func testNucleobaseCount() {
        
        let dna = DNA.test(
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
        
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
}
