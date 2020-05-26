//
//  Vertex.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 3/12/17.
//  Copyright © 2017 carlbrenneisen. All rights reserved.
//

import Foundation

final public class Vertex<T: BioSequence> {

    public let bioSequence: T

    internal init(bioSequence: T){
        self.bioSequence = bioSequence
    }
}

extension Vertex: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(bioSequence.hashValue)
    }
}

extension Vertex: Equatable {

    public static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.bioSequence.sequenceString == rhs.bioSequence.sequenceString
    }
}
