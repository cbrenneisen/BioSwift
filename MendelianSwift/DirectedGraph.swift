//
//  DirectedGraph.swift
//  MendelianSwift
//
//  Created by mac on 10/26/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public class DirectedGraph<T: BioSequence>: MendelGraph<T>, MyGraph {
    
    public var edges: Set<Edge<T>> {
        var allEdges = Set<Edge<T>>()
        
        queue.sync(flags: .barrier) {
            
            // - there are no duplicate edges, so just get the union of all edge lists
            self.structure.values.forEach() {
                allEdges.formUnion($0.getEdges())
            }
        }
        return allEdges
    }
    
    public func removeVertex(vertex: Vertex<T>) {
        
        queue.async(flags: .barrier) { [unowned self, unowned vertex] in
            
            // - go through all the other vertices and remove edges to this vertex
            for v in self.structure.keys {
                // - ignore edgeList for current vertex
                guard v != vertex else { continue }
                
                // - remove in place
                self.structure[v]?.removeEdge(toVertex: vertex)
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
            
            // - create the new edge and add to the corresponding EdgeList
            let edge = Edge(from: origin, to: destination, weight: weight ?? 0)
            self.structure[origin]?.addEdge(edge: edge)
        }
    }
    
    //remove the edge going from one vertex to another
    public func removeEdge(from origin: Vertex<T>, to destination: Vertex<T>) {
        
        queue.async(flags: .barrier) { [unowned self] in
            //remove the edge that goes to the 'toVertex'
            self.structure[origin]?.removeEdge(toVertex: destination)
        }
    }
}
