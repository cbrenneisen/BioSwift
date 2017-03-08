//
//  BioGraph.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 02/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//

import Foundation

public struct Edge<T: BioSequence>: Hashable {
    
    public let from: Vertex<T>
    public let to: Vertex<T>
    
    fileprivate init(from: Vertex<T>, to: Vertex<T>){
        self.from = from
        self.to = to
    }
    
    public var hashValue: Int {
        //avoid multiple edges going to the same vertex
        return to.hashValue
    }
    
    public static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return ((lhs.to == rhs.to) && (lhs.from == rhs.from))
    }
    
    public func print(){
        Swift.print("\(from.bioSequence.sequence) - \(to.bioSequence.sequence)")
    }
}

public class Vertex<T: BioSequence>: Hashable {

    public let bioSequence: T
    
    fileprivate init(bioSequence: T){
        self.bioSequence = bioSequence
    }
    
    public var hashValue: Int {
        return self.bioSequence.hashValue
    }
    
    public static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.bioSequence.sequence == rhs.bioSequence.sequence
    }
}

fileprivate class EdgeList<T: BioSequence> {
    
    private var edges: Set<Edge<T>>
    public weak var vertex: Vertex<T>?
    
    public init (originVertex: Vertex<T>){
        //this merely exists to enforce that the edge list uses the correct generic type
        edges =  Set<Edge<T>>()
        vertex = originVertex
    }
    
    func addEdge(edge: Edge<T>){
        edges.insert(edge)
    }
    
    func removeEdge(toVertex: Vertex<T>){
        //remove all edges where the destination vertex is equal to 'toVertex'
        for e in edges {
            if e.to == toVertex {
                edges.remove(e)
            }
        }
        //edges = edges.filter({ $0.to == toVertex })
    }
    
    func getEdges()->Set<Edge<T>> {
        return edges
    }
}

public class BioGraph<T: BioSequence> {
    
    private var structure: [Vertex<T>: EdgeList<T>]
    
    //for thread safety
    private let bioGraphQueue = DispatchQueue(label: "com.mendelianSwift.BioGraph.Queue",
                                              attributes: .concurrent)

    public init(){
        structure = [:]
    }
    
    //MARK: Vertex Functions
    
    //add a new vertex to the graph and return a reference to it
    public func createVertex(bioSequence: T) -> Vertex<T> {
        //create vertex and corresponding edgelist
        let newVertex = Vertex(bioSequence: bioSequence)
        bioGraphQueue.sync(flags: .barrier) { [unowned self] in

            if (self.structure[newVertex] != nil){
                //duplicate vertex - don't overwrite, but do log error
                NSLog("WARNING! Tried to add duplicate vertex: %@", bioSequence.sequence)
            }else {
                let newEdgeList = EdgeList(originVertex: newVertex)
                self.structure[newVertex] = newEdgeList
            }
        }
        
        return newVertex
    }

    //remove a vertex and all associated edges from the graph
    public func removeVertex(vertex: Vertex<T>) {
        
        //in order for this to be successful, we need to:
        //1) remove all edges going to this vertex
        //2) remove all edges going out
        //3) remove the vertex itself
        
        bioGraphQueue.async(flags: .barrier) { [unowned self, unowned vertex] in
            
            guard let _ = self.structure[vertex] else{
                //invalid vertex, nothing to do
                return
            }
            
            //remove the reverse of all edges from the graph (edges coming in)
            for edgeL in self.structure.values {
                //ignore edgeList for current vertex
                if edgeL.vertex != vertex {
                    edgeL.removeEdge(toVertex: vertex)
                }
            }
            
            //remove edges going out and the vertex itself
            self.structure.removeValue(forKey: vertex)
        }
    }
    
    //returns the set of all vertices in the graph
    public func getAllVertices() -> Set<Vertex<T>> {
        
        var vertices: Set<Vertex<T>>?
        bioGraphQueue.sync(flags: .barrier) { [unowned self] in
            vertices = Set(self.structure.keys)
        }
        return vertices!
    }
    
    //returns all vertices that are directly connected to the given vertex
    public func getDestinationVertices(fromVertex: Vertex<T>)  -> Set<Vertex<T>> {
        var vertices: Set<Vertex<T>>?
        bioGraphQueue.sync(flags: .barrier) { [unowned self, unowned fromVertex] in
            if let eList = self.structure[fromVertex] {
                //return the 'to' vertex for each of the edges of the given vertex
                vertices = Set(eList.getEdges().map({ $0.to }))
            }else {
                //invalid vertex - just return an empty set
                vertices = Set()
            }
        }
        return vertices!

    }

    //MARK: Edge Functions
    
    //add an edge going from one vertex to another
    public func addEdge(fromVertex: Vertex<T>, toVertex: Vertex<T>) {
        
        bioGraphQueue.async(flags: .barrier) { [unowned self] in

            //grab the corresponding EdgeList
            guard let edgeList = self.structure[fromVertex] else {
                //invalid vertex, nothing to do
                return
            }
            
            //create the new edge
            let edge = Edge(from: fromVertex, to: toVertex)
            
            //add the edge to the corresponding EdgeList
            edgeList.addEdge(edge: edge)
        }
    }
    
    //remove the edge going from one vertex to another
    public func removeEdge(fromVertex: Vertex<T>, toVertex: Vertex<T>) {
        
        bioGraphQueue.async(flags: .barrier) { [unowned self] in

            //grab the corresponding EdgeList
            guard let edgeList = self.structure[fromVertex] else {
                //invalid vertex, nothing to do
                return
            }
            
            //remove the edge that goes to the 'toVertex'
            edgeList.removeEdge(toVertex: toVertex)
        }
    }
    
    //returns all edges in the graph
    public func getAllEdges() -> Set<Edge<T>> {
        
        var edges = Set<Edge<T>>()
        bioGraphQueue.sync(flags: .barrier) { [unowned self] in
            for eList in self.structure.values {
                edges.formUnion(eList.getEdges())
            }
        }
        return edges
    }
    
    //returns the set of edges from a given vertex
    public func getEdges(fromVertex: Vertex<T>) -> Set<Edge<T>> {
        
        var edges: Set<Edge<T>>?
        bioGraphQueue.sync(flags: .barrier) { [unowned self, unowned fromVertex] in
            edges = self.structure[fromVertex]?.getEdges()
        }
        return edges!
    }
    
    //MARK: Utility Functions
    public func removeAll(keepingCapacity: Bool) {
        structure.removeAll(keepingCapacity: keepingCapacity)
    }

}
