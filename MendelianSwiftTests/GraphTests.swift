//
//  GraphTests.swift
//  MendelianSwiftTests
//
//  Created by Carlos Brenneisen on 10/27/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

final class GraphTests: MendelianTestCase {

    func testEmpty(){
        
        let sequences: [DNA] = []
        let graph = BioGraphFactory.create(with: sequences, directed: true, weighted: true)
        
        XCTAssertTrue(graph.vertices.isEmpty, "There should be no vertices in the graph")
    }

}
