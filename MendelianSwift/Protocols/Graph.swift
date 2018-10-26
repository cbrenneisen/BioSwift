//
//  Graph.swift
//  MendelianSwift
//
//  Created by mac on 10/25/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public class MendelGraph<T: BioSequence> {
    
    internal var structure: [Vertex<T>: EdgeList<T>] = [:]
    internal let queue = DispatchQueue(label: "com.mendelianSwift.BioGraph.Queue",
                                              attributes: .concurrent)
    
    /**
     The set of all vertices in the graph
    */
    public var vertices: Set<Vertex<T>> {
        var _vertices: Set<Vertex<T>> = Set()
        queue.sync(flags: .barrier) { [unowned self] in
            _vertices = Set(self.structure.keys)
        }
        return _vertices
    }
    
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
    
    /**
     Get all vertices that are directly connected to the given vertex
     - parameter vertex: The origin vertex to search from
     - returns: the set of all vertices that can be reached directly from the origin
    */
    public func destinations(from vertex: Vertex<T>)  -> Set<Vertex<T>> {
        var vertices: Set<Vertex<T>> = Set()
        queue.sync(flags: .barrier) {
            guard let eList = self.structure[vertex] else { return }
            
            //return the 'to' vertex for each of the edges of the given vertex
            vertices = Set(eList.getEdges().map({ $0.to }))
        }
        return vertices
    }
    
    //returns the set of edges from a given vertex
    public func edges(from origin: Vertex<T>) -> Set<Edge<T>> {
        
        var edges: Set<Edge<T>> = Set()
        queue.sync(flags: .barrier) {
            if let edgeList = self.structure[origin] {
                edges = edgeList.getEdges()
            }
        }
        return edges
    }
    
    
    //returns whether or not an edge exists between two Vertices
    public func edgeExists(from origin: Vertex<T>, to destination: Vertex<T>) -> Bool {
        
        var exists = false
        queue.sync {
            //get the edges for the 'origin'
            guard let edgeList = self.structure[origin] else { return }
            let edges = edgeList.getEdges()
            
            for e in edges {
                if e.to == destination {
                    //if there is an edge to the 'toVertex' return true
                    exists = true
                    break
                }
            }
        }
        return exists
    }

    //MARK: Utility Functions
    public func removeAll(keepingCapacity: Bool = false) {
        structure.removeAll(keepingCapacity: keepingCapacity)
    }
}

public protocol MyGraph: class {
    
    associatedtype T: BioSequence
    
    var vertices: Set<Vertex<T>> { get }
    var edges: Set<Edge<T>> { get }
    
    // - vertex operations
    func createVertex(bioSequence: T) -> Vertex<T>
    func removeVertex(vertex: Vertex<T>)
    func destinations(from vertex: Vertex<T>) -> Set<Vertex<T>>
    
    // - edge operations
    func addEdge(from origin: Vertex<T>, to destination: Vertex<T>, weight: Int?)
    func removeEdge(from origin: Vertex<T>, to destination: Vertex<T>)
    func edges(from origin: Vertex<T>) -> Set<Edge<T>>
    func edgeExists(from origin: Vertex<T>, to destination: Vertex<T>) -> Bool
    
    // - utility
    func removeAll(keepingCapacity: Bool)
}

public extension MyGraph {
    
    public static func create<T: BioSequence, U: MyGraph>(type: T, directed: Bool, weighted: Bool, values: [T]) -> U {
        
    }
    
    public func addEdge(from origin: Vertex<T>, to destination: Vertex<T>){
        addEdge(from: origin, to: destination, weight: nil)
    }
    
    //returns whether or not an edge exists between two BioSequences
    public func edgeExists(from origin: T, to destination: T) -> Bool {
        
        let v1 = Vertex(bioSequence: origin)
        let v2 = Vertex(bioSequence: destination)
        
        return edgeExists(from: v1, to: v2)
    }
}


