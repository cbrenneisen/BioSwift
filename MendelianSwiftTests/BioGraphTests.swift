//
//  BioGraphTests.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 3/6/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

class BioGraphTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {

        let seqGraph = BioGraph<DNA>()
        
        guard let dna1 = DNA(sequence: "ATCCAGCT"),
              let dna2 = DNA(sequence: "GGGCAACT"),
              let dna3 = DNA(sequence: "ATGGATCT"),
              let dna4 = DNA(sequence: "AAGCAACC"),
              let dna5 = DNA(sequence: "TTGGAACT"),
              let dna6 = DNA(sequence: "ATGCCATT"),
              let dna7 = DNA(sequence: "ATGGCACT") else {
            XCTFail("Invalid DNA sequence")
            return
        }
        
        let v1 = seqGraph.createVertex(sequence: dna1)
        let v2 = seqGraph.createVertex(sequence: dna2)
        let v3 = seqGraph.createVertex(sequence: dna3)
        let v4 = seqGraph.createVertex(sequence: dna4)
        let v5 = seqGraph.createVertex(sequence: dna5)
        let v6 = seqGraph.createVertex(sequence: dna6)
        let v7 = seqGraph.createVertex(sequence: dna7)

        let vertices = seqGraph.getVertices()
        
        XCTAssertTrue(vertices.contains(v1), "Did not add first vertex")
        XCTAssertTrue(vertices.contains(v2), "Did not add second vertex")
        XCTAssertTrue(vertices.contains(v3), "Did not add third vertex")
        XCTAssertTrue(vertices.contains(v4), "Did not add fourth vertex")
        XCTAssertTrue(vertices.contains(v5), "Did not add fifth vertex")
        XCTAssertTrue(vertices.contains(v6), "Did not add sixth vertex")
        XCTAssertTrue(vertices.contains(v7), "Did not add seventh vertex")
        
        seqGraph.addEdge(fromVertex: v1, toVertex: v2)
        seqGraph.addEdge(fromVertex: v1, toVertex: v3)
        seqGraph.addEdge(fromVertex: v1, toVertex: v4)
        
        let vertices1 = seqGraph.getEdges(forVertex: v1)
        let dest1 = vertices1.map({ $0.to })
        
        XCTAssertTrue(dest1.contains(v2), "Did not add edge to second vertex")
        XCTAssertTrue(dest1.contains(v3), "Did not add edge to third vertex")
        XCTAssertTrue(dest1.contains(v4), "Did not add edge to fourth vertex")

        seqGraph.addEdge(fromVertex: v4, toVertex: v3)
        seqGraph.addEdge(fromVertex: v2, toVertex: v3)
        seqGraph.addEdge(fromVertex: v3, toVertex: v5)

        let allEdges = seqGraph.getAllEdges()
        for edge in allEdges{
            edge.print()
        }
        XCTAssertEqual(allEdges.count, 6, "Incorrect number of edges added")
        
        seqGraph.removeVertex(vertex: v3)
        let vertices2 = seqGraph.getVertices()
        XCTAssertFalse(vertices2.contains(v3), "Vertex 3 was not removed")

        let allEdges2 = seqGraph.getAllEdges()
        XCTAssertEqual(allEdges2.count, 2, "Edges going to/from Vertex 3 were not removed ")
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
