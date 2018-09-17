//
//  RNATests.swift
//  MendelianSwiftTests
//
//  Created by mac on 9/17/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
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
