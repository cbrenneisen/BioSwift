//
//  Vertex.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 3/12/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import Foundation

final public class Vertex<T: BioSequence>: Hashable {
    
    public let bioSequence: T
    
    internal init(bioSequence: T){
        self.bioSequence = bioSequence
    }
    
    public var hashValue: Int {
        return self.bioSequence.hashValue
    }
    
    public static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.bioSequence.sequence == rhs.bioSequence.sequence
    }
}
