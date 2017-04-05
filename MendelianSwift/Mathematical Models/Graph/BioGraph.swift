//
//  BioGraph.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 02/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//

import Foundation

fileprivate enum BioGraphType {
    
    case directedUnweighted
    case directedWeighted
    case undirectedUnweighted
    case undirectedWeighted
}

public class BioGraph<T: BioSequence> {
    
    //MARK: Properties
    
    private var structure: [Vertex<T>: EdgeList<T>]
    private let type: BioGraphType
    
    public lazy var isDirected: Bool = {
        return (self.type == .directedWeighted || self.type == .directedUnweighted)
    }()
    
    public lazy var isWeighted: Bool = {
        return (self.type == .directedWeighted || self.type == .undirectedWeighted)
    }()

    
    //for thread safety
    private let bioGraphQueue = DispatchQueue(label: "com.mendelianSwift.BioGraph.Queue",
                                              attributes: .concurrent)

    //MARK: Initializers
    
    convenience init() {
        //default graph is directed, unweighted, and created with no vertices
        self.init(directed: false, weighted: false, bioSequences: [])
    }
    
    public init(directed: Bool, weighted: Bool, bioSequences: [T]){
        
        if directed {
            if weighted {
                self.type = .directedWeighted
            }else {
                self.type = .directedUnweighted
            }
        }else{
            if weighted {
                self.type = .undirectedWeighted
            }else{
                self.type = .directedUnweighted
            }
        }
        
        structure = [:]
        for seq in bioSequences {
            _ = self.createVertex(bioSequence: seq)
        }
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
            
            guard let outgoingEdges = self.structure[vertex] else{
                //invalid vertex, nothing to do
                return
            }
            
            //remove the reverse of all edges from the graph (edges coming in)
            if self.isDirected{
                
                //we need to go through all the other vertices and remove edges to this vertex
                for destVertex in self.structure.keys {
                    //ignore edgeList for current vertex
                    if destVertex != vertex {
                        self.structure[destVertex]?.removeEdge(toVertex: vertex)
                    }
                }
            }
            else{
                
                //we can simply remove the inverse of all this vertex's edges
                let edges = outgoingEdges.getEdges()
                for edge in edges {
                    //remove the edge from the dest vertex to the given vertex
                    self.structure[edge.to]?.removeEdge(toVertex: vertex)
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
    
    //add an edge going from one vertex to another with no weight
    public func addEdge(fromVertex: Vertex<T>, toVertex: Vertex<T>) {
        self.addEdge(fromVertex: fromVertex, toVertex: toVertex, withWeight: MendelConstants.defaultEdgeWeight)
    }
    
    //add an edge going from one vertex to another with a set weight
    public func addEdge(fromVertex: Vertex<T>, toVertex: Vertex<T>, withWeight: Int) {
        
        bioGraphQueue.async(flags: .barrier) { [unowned self] in
            
            guard let _ = self.structure[fromVertex],
                  let _ = self.structure[toVertex] else {
                //if either vertex is invalid, do not add
                return
            }
            
            //ignore weight if the graph is not weighted
            var weight = MendelConstants.defaultEdgeWeight
            if self.isWeighted {
                weight = withWeight
            }
            
            //create the new edge and add to the corresponding EdgeList
            let edge = Edge(from: fromVertex, to: toVertex, weight: weight)
            self.structure[fromVertex]?.addEdge(edge: edge)
            
            if !self.isDirected {
                //graph is undirected so we need an edge going the other way too
                let inverseEdge = Edge(from: toVertex, to: fromVertex, weight: weight)
                self.structure[toVertex]?.addEdge(edge: inverseEdge)
            }
        }
    }
    
    //remove the edge going from one vertex to another
    public func removeEdge(fromVertex: Vertex<T>, toVertex: Vertex<T>) {
        
        bioGraphQueue.async(flags: .barrier) { [unowned self] in
            
            //remove the edge that goes to the 'toVertex'
            self.structure[fromVertex]?.removeEdge(toVertex: toVertex)
            
            if (!self.isDirected){
                //if undirected, we need to remove the inverse vertex
                self.structure[toVertex]?.removeEdge(toVertex: fromVertex)
            }
        }
    }
    
    //returns all edges in the graph
    public func getAllEdges() -> Set<Edge<T>> {
        
        var allEdges = Set<Edge<T>>()
        bioGraphQueue.sync(flags: .barrier) { [unowned self] in
            
            if self.isDirected {
                
                //no duplicate edges, so just get the union of all edge lists
                for eList in self.structure.values {
                    allEdges.formUnion(eList.getEdges())
                }
            }else{
                
                //need to filter out inverse edges
                for eList in self.structure.values {
                    let edges = eList.getEdges()
                    for edge in edges {
                        let inverseEdge = Edge(from: edge.to, to: edge.from)
                        if !edges.contains(inverseEdge){
                            //only insert if the inverse is not found
                            allEdges.insert(edge)
                        }
                    }
                }
            }
        }
        return allEdges
    }
    
    //returns the set of edges from a given vertex
    public func getEdges(fromVertex: Vertex<T>) -> Set<Edge<T>> {
        
        var edges: Set<Edge<T>>?
        bioGraphQueue.sync(flags: .barrier) { [unowned self, unowned fromVertex] in
            edges = self.structure[fromVertex]?.getEdges()
        }
        if let _ = edges {
            return edges!
        }
        return Set()
    }
    
    //returns whether or not an edge exists between two BioSequences
    public func edgeExists(fromSequence: T, toSequence: T) -> Bool {

        let fromVertex = Vertex(bioSequence: fromSequence)
        let toVertex   = Vertex(bioSequence: toSequence)

        return edgeExists(fromVertex: fromVertex, toVertex: toVertex)
    }
    
    //returns whether or not an edge exists between two Vertices
    public func edgeExists(fromVertex: Vertex<T>, toVertex: Vertex<T>) -> Bool {
        
        var exists = false
        bioGraphQueue.sync { [unowned self, unowned fromVertex, unowned toVertex] in
            //get the edges for the 'fromVertex'
            if let edgeList = self.structure[fromVertex]{
                let edges = edgeList.getEdges()
                for e in edges {
                    if e.to == toVertex {
                        //if there is an edge to the 'toVertex' return true
                        exists = true
                        break
                    }
                }
            }
        }
        return exists
    }
    
    //MARK: Utility Functions
    public func removeAll(keepingCapacity: Bool) {
        
        bioGraphQueue.async { [unowned self] in
            self.structure.removeAll(keepingCapacity: keepingCapacity)
        }
    }
    
}
