//
//  Edge.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 3/12/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import Foundation

public struct Edge<T: BioSequence>: Hashable {
    
    public let from: Vertex<T>
    public let to: Vertex<T>
    private let weight: Int?
    
    internal init(from: Vertex<T>, to: Vertex<T>, weight: Int?){
        self.from = from
        self.to = to
        self.weight = weight
    }
    
    public var hashValue: Int {
        //there should only be one edge per destination vertex anyway
        return to.hashValue
    }
    
    public static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return ((lhs.to == rhs.to) && (lhs.from == rhs.from))
    }
    
    public func print(){
        Swift.print("\(from.bioSequence.sequence) - \(to.bioSequence.sequence)")
    }
}
