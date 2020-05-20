//
//  GraphTests.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 10/27/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
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
