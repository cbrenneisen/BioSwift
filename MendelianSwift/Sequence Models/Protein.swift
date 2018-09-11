//
//  Protein.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct Protein: BioSequence {
    
    public typealias Base = AminoAcid
    
    public var sequence: [Base]
    public var id: String?
    
    /**
     Create a new Protein object
     - parameter id: the identifier of the sequence
     - parameter sequence: a series of Amino Acids that make up the sequence
     */
    public init(id: String?, sequence: [Base]){
        self.sequence = sequence
        self.id = id
    }
}
