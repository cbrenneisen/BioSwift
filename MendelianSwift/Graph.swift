//
//  Graph.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 02/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//

import Foundation

public struct Edge<T: BioSequence> {
    
    public let from: Vertex<T>
    public let to: Vertex<T>
    
    public func print(){
        Swift.print(" \(from.bioSequence.sequence) - \(to.bioSequence.sequence)")
    }
}

public class Vertex<T: BioSequence>: Hashable {

    public let bioSequence: T
    public let index: Int
    
    public init(sequence: T, index: Int){
        self.bioSequence = sequence
        self.index = index
    }
    
    public var hashValue: Int {
        return self.index.hashValue
    }
    
    public static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.bioSequence.sequence == rhs.bioSequence.sequence
    }
}

fileprivate class EdgeList<T: BioSequence> {
    
    let vertex: Vertex<T>
    private var edges: [Edge<T>]
    
    init (vertex: Vertex<T>){
        self.vertex = vertex
        edges = []
    }
    
    func addEdge(edge: Edge<T>){
        edges.append(edge)
    }
    
    func removeEdge(toVertex: Vertex<T>){
        //remove all edges where the destination vertex is equal to 'toVertex'
        edges = edges.filter({ $0.to.index != toVertex.index })
    }
    
    func getEdges()->[Edge<T>] {
        return edges
    }
    
}


//TODO: MAKE ALL THIS WORK WITH MULTITHREADING!!!!


public class BioGraph<T: BioSequence> {
    
    private var vertices: [Vertex<T>]
    private var adjacencyList: [EdgeList<T>]
    
    //for thread safety
    private let bioGraphQueue = DispatchQueue(label: "com.mendelianSwift.BioGraph.Queue",
                                              attributes: .concurrent)

    public init(){
        vertices = []
        adjacencyList = []
    }
    
    //add a new vertex to the graph and return a reference to it
    public func createVertex(sequence: T) -> Vertex<T> {
        //create vertex and add it to the list
        var vertex: Vertex<T>?
        bioGraphQueue.sync(flags: .barrier) {
            
            vertex = Vertex(sequence: sequence, index: vertices.count)
            vertices.append(vertex!)
        
            //create corresponding EdgeList
            let edgeList = EdgeList(vertex: vertex!)
            adjacencyList.append(edgeList)
        }
            
        return vertex!
    }
    
    //remove a vertex and all associated edges from the graph
    public func removeVertex(vertex: Vertex<T>) {
     
        //in order for this to be successful, we need to:
        //1) remove all edges going to this vertex
        //2) remove all edges going out
        //3) remove the vertex itself
        
        //grab the corresponding list of edges
        let index = vertex.index
        let edges = adjacencyList[index].getEdges()
        
        //remove the reverse of all edges from the graph (edges coming in)
        for edge in edges {
            removeEdge(fromVertex: edge.to, toVertex: edge.from)
        }
        
        //remove edges going out
        adjacencyList.remove(at: index)
        
        //remove the vertex
        vertices.remove(at: index)
    }
    
    //add an edge going from one vertex to another
    public func addEdge(fromVertex: Vertex<T>, toVertex: Vertex<T>) {
        
        //grab the corresponding EdgeList
        let index = fromVertex.index
        let edgeList = adjacencyList[index]
        
        //create the new edge
        let edge = Edge(from: fromVertex, to: toVertex)
        
        //add the edge to the corresponding EdgeList
        edgeList.addEdge(edge: edge)
    }
    
    //remove the edge going from one vertex to another
    public func removeEdge(fromVertex: Vertex<T>, toVertex: Vertex<T>) {

        //grab the corresponding EdgeList
        let index = fromVertex.index
        let edgeList = adjacencyList[index]

        //remove the edge that goes to the 'toVertex'
        edgeList.removeEdge(toVertex: toVertex)
    }
}

