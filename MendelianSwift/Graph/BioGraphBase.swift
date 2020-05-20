//
//  BioGraph.swift
//  BioSwift
//
//  Created by Carl Brenneisen on 02/22/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.
//

import Foundation

public class BioGraph<T: BioSequence>: BioGraphInterface {
    
    //MARK: Properties
    internal var structure: [Vertex<T>: EdgeList<T>] = [:]
    internal let queue = DispatchQueue(label: "com.mendelianSwift.BioGraph.Queue",
                                       attributes: .concurrent)
    
    internal init(sequences: [T]) {
        
        structure = [:]
        sequences.forEach(){
            _ = createVertex(from: $0)
        }
    }
    
    convenience init() {
        self.init(sequences: [])
    }
    
    //MARK: Utility Functions
    public func removeAll(keepingCapacity: Bool = false) {
        structure.removeAll(keepingCapacity: keepingCapacity)
    }
    
    //MARK: Non implemented functionalities
    public func addEdge(from origin: Vertex<T>, to destination: Vertex<T>, weight: Int?) {
        fatalError("Must override in sub class")
    }
    
    public var edges: Set<Edge<T>> {
        fatalError("Must override in sub class")
    }
    
    public func removeVertex(vertex: Vertex<T>) {
        fatalError("Must override in sub class")
    }
    
    public func removeEdge(from origin: Vertex<T>, to destination: Vertex<T>) {
        fatalError("Must override in sub class")
    }
}

//MARK: - Default Vertex Functions
public extension BioGraph {
    
    /**
     The set of all vertices in the graph
     */
    var vertices: Set<Vertex<T>> {
        var _vertices: Set<Vertex<T>> = Set()
        queue.sync(flags: .barrier) { [unowned self] in
            _vertices = Set(self.structure.keys)
        }
        return _vertices
    }
    
    func createVertex(from sequence: T) -> Vertex<T> {
        //create vertex and corresponding edgelist
        let newVertex = Vertex(bioSequence: sequence)
        queue.sync(flags: .barrier) { [unowned self] in
            
            if (self.structure[newVertex] != nil){
                //duplicate vertex - don't overwrite, but do log error
                NSLog("WARNING! Tried to add duplicate vertex: %@", sequence.sequenceString)
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
    func destinations(from vertex: Vertex<T>)  -> Set<Vertex<T>> {
        var vertices: Set<Vertex<T>> = Set()
        queue.sync(flags: .barrier) {
            guard let eList = self.structure[vertex] else { return }
            
            //return the 'to' vertex for each of the edges of the given vertex
            vertices = Set(eList.getEdges().map({ $0.to }))
        }
        return vertices
    }
}

//MARK: - Default Edge Functions
public extension BioGraph {

    //returns the set of edges from a given vertex
    func edges(from origin: Vertex<T>) -> Set<Edge<T>> {
        
        var edges: Set<Edge<T>> = Set()
        queue.sync(flags: .barrier) {
            if let edgeList = self.structure[origin] {
                edges = edgeList.getEdges()
            }
        }
        return edges
    }

    //returns whether or not an edge exists between two Vertices
    func edgeExists(from origin: Vertex<T>, to destination: Vertex<T>) -> Bool {
        
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
}

