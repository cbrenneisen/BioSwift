//
//  Edge.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 3/12/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.
//

import Foundation

public struct Edge<T: BioSequence> {

    public let from: Vertex<T>
    public let to: Vertex<T>
    private var weight: Int

    init(from: Vertex<T>, to: Vertex<T>) {
        self.init(from: from, to: to, weight: MendelConstants.defaultEdgeWeight)
    }

    internal init(from: Vertex<T>, to: Vertex<T>, weight: Int){
        self.from = from
        self.to = to
        self.weight = weight
    }

    public mutating func updateWeight(weight: Int){
        self.weight = weight
    }

    public func print(){
        Swift.print("\(from.bioSequence.sequenceString) - \(to.bioSequence.sequenceString)")
    }
}

extension Edge: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(to.hashValue)
        hasher.combine(from.hashValue)
    }
}

extension Edge: Equatable {

    public static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return ((lhs.to == rhs.to) && (lhs.from == rhs.from))
    }
}

