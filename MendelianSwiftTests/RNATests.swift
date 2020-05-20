//
//  RNATests.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 9/17/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class RNATests: MendelianTestCase {

    func testTranslate(){
        guard let rna = RNA(contentsOfFile: "rna1") else {
            XCTFail("Could not read RNA")
            return
        }
        
        // - create protein
        let protein = rna.translate()
        
        // - test string
        XCTAssertEqual(protein.sequenceString, "MAMAPRTEINSTRING")
    }
}
