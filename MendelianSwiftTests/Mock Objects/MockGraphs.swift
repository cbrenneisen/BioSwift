//
//  MockGraphs.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 3/13/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.
//

import XCTest
import Foundation
@testable import MendelianSwift

fileprivate let minLength = 30
fileprivate let maxLength = 30
fileprivate let vertexCount = 20

//class MockDNAGraph: BioGraph<DNA> {
//
//    public init(directed: Bool, weighted: Bool, mockEdges: Bool){
//
//        let allDNA = [DNA].random(min: minLength, max: maxLength, count: vertexCount)
////        let allDNA = MockService.generateRandomDNA(minLength: minLength,
////                                                   maxLength: maxLength, count: vertexCount)
//        super.init(directed: directed, weighted: weighted, bioSequences: Array(allDNA))
//
//        let vertices = self.getAllVertices()
//        if mockEdges {
//            for v1 in vertices{
//                for v2 in vertices{
//                    if v1 == v2 {
//                        continue
//                    }
//
//                    if (Utility.byChance()){
//                        self.addEdge(fromVertex: v1, toVertex: v2)
//                    }
//                }
//            }
//        }
//    }
//}
//
//class MockRNAGraph: BioGraph<RNA> {
//
//    public init(directed: Bool, weighted: Bool, mockEdges: Bool){
//
//
//        let allRNA = [RNA].random(min: minLength, max: maxLength, count: vertexCount)
//        super.init(directed: directed, weighted: weighted, bioSequences: Array(allRNA))
//
//        let vertices = self.getAllVertices()
//        if mockEdges {
//            for v1 in vertices{
//                for v2 in vertices{
//                    if v1 == v2 {
//                        continue
//                    }
//
//                    if (Utility.byChance()){
//                        self.addEdge(fromVertex: v1, toVertex: v2)
//                    }
//                }
//            }
//        }
//    }
//}
//
//class MockProteinGraph: BioGraph<Protein> {
//
//    public init(directed: Bool, weighted: Bool, mockEdges: Bool){
//
//
//        let allProtein = [Protein].random(min: minLength, max: maxLength, count: vertexCount)
//        super.init(directed: directed, weighted: weighted, bioSequences: Array(allProtein))
//
//        let vertices = self.getAllVertices()
//        if mockEdges {
//            for v1 in vertices{
//                for v2 in vertices{
//                    if v1 == v2 {
//                        continue
//                    }
//
//                    if (Utility.byChance()){
//                        self.addEdge(fromVertex: v1, toVertex: v2)
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//
//class MockGraphTests: XCTestCase {
//
//    override func setUp() {
//        super.setUp()
//
//        //validate constants
//        self.continueAfterFailure = false
//        XCTAssertLessThanOrEqual(minLength, maxLength,
//                                 "Min length should be less than or equal to the max length")
//        XCTAssertGreaterThan(minLength, 0, "Sequences should be at least 1 character")
//        XCTAssertGreaterThan(vertexCount, 0, "Graphs should have at least one vertex")
//
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//
//    //test both of the edgeExists functions
//    func testMockDNA(){
//
//        //test without edges
//        let dnaGraph1 = MockDNAGraph(directed: true, weighted: true, mockEdges: false)
//        let vertices1 = dnaGraph1.getAllVertices()
//        XCTAssertEqual(vertices1.count, vertexCount, "Should have created \(vertexCount) vertices")
//        XCTAssertEqual(dnaGraph1.getAllEdges().count, 0,
//                       "Should not have created edges")
//        for v in vertices1{
//            XCTAssertGreaterThanOrEqual(v.bioSequence.length, minLength,
//                                        "Sequence should be at least as long as the minimum length")
//            XCTAssertLessThanOrEqual(v.bioSequence.length, minLength,
//                                        "Sequence should not be longer than the maximum length")
//        }
//
//        //test with edges
//        let dnaGraph2 = MockDNAGraph(directed: true, weighted: true, mockEdges: true)
//        XCTAssertEqual(dnaGraph2.getAllVertices().count, vertexCount,
//                       "Should have created \(vertexCount) vertices")
//        XCTAssertGreaterThan(dnaGraph2.getAllEdges().count, 0,
//                       "Should have created some edges")
//    }
//
//
//}
//
//
