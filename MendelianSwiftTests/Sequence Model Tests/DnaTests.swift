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
}
