//
//  BioSequence+Computed.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 9/14/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
     Raw string value of the sequence
    */
    var sequenceString: String {
        return sequence.map{ $0.string }.reduce("", +)
    }
    
    /**
     The length of the sequence
    */
    var length: Int {
        return self.sequence.count
    }
    
    /**
     Returns the count of all bases in the DNA object
     */
    var baseCount: [Base: Int] {
        return sequence.reduce(into: [Base: Int]()){
            $0[$1, default: 0] += 1
        }
    }
}
