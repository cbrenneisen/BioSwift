//
//  EdgeList.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 3/12/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import Foundation

final public class EdgeList<T: BioSequence> {
    
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

