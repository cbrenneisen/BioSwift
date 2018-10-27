//
//  Graph.swift
//  MendelianSwift
//
//  Created by mac on 10/25/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public protocol BioGraphInterface {
    
    associatedtype T: BioSequence
    
    var vertices: Set<Vertex<T>> { get }
    var edges: Set<Edge<T>> { get }
    
    // - vertex operations
    func createVertex(from sequence: T) -> Vertex<T>
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

public extension BioGraphInterface {
    
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
