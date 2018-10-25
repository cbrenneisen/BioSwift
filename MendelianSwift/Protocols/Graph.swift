//
//  Graph.swift
//  MendelianSwift
//
//  Created by mac on 10/25/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

class MendelGraph<T: BioSequence> {
    
    private(set) var structure: [Vertex<T>: EdgeList<T>] = [:]
    internal let queue = DispatchQueue(label: "com.mendelianSwift.BioGraph.Queue",
                                              attributes: .concurrent)
    
    public func createVertex(bioSequence: T) -> Vertex<T> {
        //create vertex and corresponding edgelist
        let newVertex = Vertex(bioSequence: bioSequence)
        queue.sync(flags: .barrier) { [unowned self] in
            
            if (self.structure[newVertex] != nil){
                //duplicate vertex - don't overwrite, but do log error
                NSLog("WARNING! Tried to add duplicate vertex: %@", bioSequence.sequenceString)
            }else {
                let newEdgeList = EdgeList(originVertex: newVertex)
                self.structure[newVertex] = newEdgeList
            }
        }
        return newVertex
    }
}

public protocol MyGraph: class {
    
    associatedtype T: BioSequence
    
    var structure: [Vertex<T>: EdgeList<T>] { get }
    var queue: DispatchQueue { get }
    
    func createVertex(bioSequence: T) -> Vertex<T>
    
    //func removeVertex(vertex: Vertex<T>)
}

class DirectedGraph<T: BioSequence>: MendelGraph<T>, MyGraph {
    
}
