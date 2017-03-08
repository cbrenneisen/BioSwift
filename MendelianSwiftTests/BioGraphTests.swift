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
    
    func testBioGraphFunctions() {

        let seqGraph = BioGraph<DNA>()
        var edgeCount = 0
        var vertexCount = 0
        
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
        
        let v1 = seqGraph.createVertex(bioSequence: dna1)
        let v2 = seqGraph.createVertex(bioSequence: dna2)
        let v3 = seqGraph.createVertex(bioSequence: dna3)
        let v4 = seqGraph.createVertex(bioSequence: dna4)
        let v5 = seqGraph.createVertex(bioSequence: dna5)
        let v6 = seqGraph.createVertex(bioSequence: dna6)
        let v7 = seqGraph.createVertex(bioSequence: dna7)
        vertexCount += 7

        //test vertex creation/addition
        let vertices = seqGraph.getAllVertices()
        XCTAssertEqual(vertices.count, vertexCount, "Did not add correct number of vertices")
        XCTAssertTrue(vertices.contains(v1), "Did not add first vertex")
        XCTAssertTrue(vertices.contains(v2), "Did not add second vertex")
        XCTAssertTrue(vertices.contains(v3), "Did not add third vertex")
        XCTAssertTrue(vertices.contains(v4), "Did not add fourth vertex")
        XCTAssertTrue(vertices.contains(v5), "Did not add fifth vertex")
        XCTAssertTrue(vertices.contains(v6), "Did not add sixth vertex")
        XCTAssertTrue(vertices.contains(v7), "Did not add seventh vertex")
        
        //test edge creation/addition
        seqGraph.addEdge(fromVertex: v1, toVertex: v2)
        seqGraph.addEdge(fromVertex: v1, toVertex: v3)
        seqGraph.addEdge(fromVertex: v1, toVertex: v4)
        edgeCount += 3
        
        //test via edgesFromVertex function
        let edges1 = seqGraph.getEdges(fromVertex: v1)
        let dest1 = edges1.map({ $0.to })
        
        XCTAssertTrue(dest1.contains(v2), "Did not add edge to second vertex")
        XCTAssertTrue(dest1.contains(v3), "Did not add edge to third vertex")
        XCTAssertTrue(dest1.contains(v4), "Did not add edge to fourth vertex")

        seqGraph.addEdge(fromVertex: v4, toVertex: v3)
        seqGraph.addEdge(fromVertex: v2, toVertex: v3)
        seqGraph.addEdge(fromVertex: v3, toVertex: v5)
        edgeCount += 3

        //test via allEdges function
        let allEdges = seqGraph.getAllEdges()
        let dest2 = allEdges.map({ $0.to })
        XCTAssertTrue(dest2.contains(v3), "Did not add edge to second vertex")
        XCTAssertTrue(dest2.contains(v5), "Did not add edge to third vertex")
        XCTAssertEqual(allEdges.count, edgeCount, "Incorrect number of edges added")
        
        //test vertex removal
        seqGraph.removeVertex(vertex: v3)
        vertexCount -= 1
        edgeCount -= 4 //three edges going to v3, one edge coming out
        let vertices2 = seqGraph.getAllVertices()
        XCTAssertFalse(vertices2.contains(v3), "Vertex 3 was not removed")
        XCTAssertEqual(vertices2.count, vertexCount, "Too many vertices were removed")
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Edges going to/from Vertex 3 were not removed ")
        
        //test adding edges again
        seqGraph.addEdge(fromVertex: v4, toVertex: v5)
        seqGraph.addEdge(fromVertex: v5, toVertex: v6)
        seqGraph.addEdge(fromVertex: v5, toVertex: v7)
        edgeCount += 3
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Incorrect number of edges added")

        //test edge removal
        seqGraph.removeEdge(fromVertex: v5, toVertex: v6)
        let v5Edges = seqGraph.getEdges(fromVertex: v5)
        let dest5 = v5Edges.map({ $0.to })
        edgeCount -= 1
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Edge was not removed")
        XCTAssertFalse(dest5.contains(v6), "Correct edge was not removed")

        //test the removal of a non-existant edge
        seqGraph.removeEdge(fromVertex: v5, toVertex: v1)
        XCTAssertEqual(seqGraph.getAllEdges().count, edgeCount, "Edge was incorrectly removed")
        
        //test the addition of a duplicate vertex
        let _ = seqGraph.createVertex(bioSequence: dna5)
        XCTAssertEqual(seqGraph.getAllVertices().count, vertexCount, "Vertex was incorrectly added")
        
        //test getDestinationVertices
        let destV1 = seqGraph.getDestinationVertices(fromVertex: v3)
        XCTAssertTrue(destV1.isEmpty, "There should be no edges for Vertex 3 because it was removed")
        
        let destV2 = seqGraph.getDestinationVertices(fromVertex: v1)
        XCTAssertTrue(destV2.contains(v2), "Vertex1 should have an edge going to Vertex 2")
        XCTAssertTrue(destV2.contains(v4), "Vertex1 should have an edge going to Vertex 4")
        
        _ = generateBioSequences(minLength: 4, maxLength: 10, count: 100)
    }
    
    func generateBioSequences(minLength: Int, maxLength: Int, count: Int) -> Set<DNA> {
    
        for _ in 1...count {
            var curDNA = ""
            let upperBound = UInt32(maxLength - minLength)
            let length = Int(arc4random_uniform(upperBound)) + minLength
            let validBases = DNA.validCharacters()
            for _ in 0...length {
                let base = String(describing: validBases.randomObject()!)

                curDNA += base
            }
            print(curDNA)
        }
        return Set()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
