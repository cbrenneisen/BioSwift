//
//  Array+DNA.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 8/25/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension Collection where Element == DNA {
    
    /**
     The DNA with the highest GC content in the collection
    */
    public var seqWithHighestGC: DNA? {
        var maxGC: Float = 0.0
        var dna: DNA?
        
        forEach(){
            let gc = $0.gcContent
            if gc > maxGC {
                maxGC = gc
                dna = $0
            }
        }
        return dna
    }    
}
