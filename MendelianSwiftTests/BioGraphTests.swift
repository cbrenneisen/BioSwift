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
        var edgeCount = 0
        
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
        edgeCount += 3
        
        let vertices1 = seqGraph.getEdges(forVertex: v1)
        let dest1 = vertices1.map({ $0.to })
        
        XCTAssertTrue(dest1.contains(v2), "Did not add edge to second vertex")
        XCTAssertTrue(dest1.contains(v3), "Did not add edge to third vertex")
        XCTAssertTrue(dest1.contains(v4), "Did not add edge to fourth vertex")

        seqGraph.addEdge(fromVertex: v4, toVertex: v3)
        seqGraph.addEdge(fromVertex: v2, toVertex: v3)
        seqGraph.addEdge(fromVertex: v3, toVertex: v5)
        edgeCount += 3

        let allEdges = seqGraph.getAllEdges()
        for edge in allEdges{
            edge.print()
        }
        XCTAssertEqual(allEdges.count, edgeCount, "Incorrect number of edges added")
        
        //test vertex removal
        seqGraph.removeVertex(vertex: v3)
        edgeCount -= 4 //three edges going to v3, one edge coming out
        let vertices2 = seqGraph.getVertices()
        XCTAssertFalse(vertices2.contains(v3), "Vertex 3 was not removed")
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Edges going to/from Vertex 3 were not removed ")
        
        //test adding edges again
        seqGraph.addEdge(fromVertex: v4, toVertex: v5)
        seqGraph.addEdge(fromVertex: v5, toVertex: v6)
        seqGraph.addEdge(fromVertex: v5, toVertex: v7)
        edgeCount += 3
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Incorrect number of edges added")

        //test edge removal
        seqGraph.removeEdge(fromVertex: v5, toVertex: v6)
        let v5Edges = seqGraph.getEdges(forVertex: v5)
        let dest5 = v5Edges.map({ $0.to })
        edgeCount -= 1
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Edge was not removed")
        XCTAssertFalse(dest5.contains(v6), "Correct edge was not removed")

        //test the removal of a non-existant edge
        seqGraph.removeEdge(fromVertex: v5, toVertex: v1)
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Edge was incorrectly removed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
