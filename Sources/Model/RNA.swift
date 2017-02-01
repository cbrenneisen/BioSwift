//
//  RNA.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public struct RNA {
    
    public let sequence: String
    
    public init(sequence: String){
        self.sequence = sequence
    }
    
    //use this to ensure that a sequence is valid
    public lazy var valid: Bool = {
        
        let nucleotides = Set("ACGU".characters)
        let filteredSeq = String(self.sequence.characters.filter { nucleotides.contains($0) })
        if filteredSeq.characters.count != self.sequence.characters.count {
            //string was invalid because there were non valid characters entered
            return false
        }
        return true
    }()

}
