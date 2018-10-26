//
//  UndirectedGraph.swift
//  MendelianSwift
//
//  Created by mac on 10/26/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public class UndirectedGraph<T: BioSequence>: MendelGraph<T>, MyGraph {
    
    public var edges: Set<Edge<T>> {
        var allEdges = Set<Edge<T>>()
        
        queue.sync(flags: .barrier) {
            
            //need to filter out inverse edges
            self.structure.values.forEach() {
                let edges = $0.getEdges()
                
                for edge in edges {
                    let inverseEdge = Edge(from: edge.to, to: edge.from)
                    
                    //only insert if the inverse is not found
                    guard !edges.contains(inverseEdge) else { continue }
                    allEdges.insert(edge)
                }
            }
        }
        return allEdges
    }
    
    public func removeVertex(vertex: Vertex<T>) {
        
        queue.async(flags: .barrier) { [unowned self, unowned vertex] in
            
            guard let outgoingEdges = self.structure[vertex] else{ return }
            
            //we can simply remove the inverse of all this vertex's edges
            let edges = outgoingEdges.getEdges()
            for edge in edges {
                //remove the edge from the dest vertex to the given vertex
                self.structure[edge.to]?.removeEdge(toVertex: vertex)
            }
            
            // - remove vertex and all of its edges
            self.structure.removeValue(forKey: vertex)
        }
    }
    
    //add an edge going from one vertex to another with a set weight
    public func addEdge(from origin: Vertex<T>, to destination: Vertex<T>, weight: Int? = nil) {
        
        queue.async(flags: .barrier) { [unowned self] in
            
            // - make sure vertices are valid
            guard self.structure[origin] != nil, self.structure[destination] != nil else {
                return
            }
            
            //            // ignore weight if the graph is not weighted
            //            var weight = MendelConstants.defaultEdgeWeight
            //            if self.isWeighted {
            //                weight = withWeight
            //            }
            
            //create the new edge and add to the corresponding EdgeList
            let edge = Edge(from: origin, to: destination, weight: weight ?? 0)
            self.structure[origin]?.addEdge(edge: edge)
            
            //graph is undirected so we need an edge going the other way too
            let inverseEdge = Edge(from: origin, to: destination, weight: weight ?? 0)
            self.structure[origin]?.addEdge(edge: inverseEdge)
        }
    }
    
    //remove the edge going from one vertex to another
    public func removeEdge(from origin: Vertex<T>, to destination: Vertex<T>) {
        
        queue.async(flags: .barrier) { [unowned self] in
            
            //remove the edge that goes to the 'toVertex'
            self.structure[origin]?.removeEdge(toVertex: destination)
            
            // - since this is undirected, we need to remove the inverse vertex
            self.structure[destination]?.removeEdge(toVertex: origin)
        }
    }
    
}
