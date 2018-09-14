//
//  BioSequence+Motifs.swift
//  MendelianSwift
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension BioSequence {
    
    /**
     Returns true if the other sequence is a subsequence of the base sequence
     */
    public func contains(_ subsequence: Self) -> Bool {
        return sequence.contains(subsequence.sequence)
    }
    
    /**
     Returns the starting index of all instances of the sub sequence
     */
    public func motifs(of subSeq: Self) -> [Int] {
        var locations: [Int] = []
        
        (0...(length-1)-subSeq.length).forEach(){ i in
            
            var match = true
            
            for (j, base2) in subSeq.sequence.enumerated() {
                // - make sure the bases are equal
                guard self[i+j] == base2 else {
                    match = false
                    break
                }
            }
            if match {
                locations.append(i)
            }
        }
        return locations
    }
}
