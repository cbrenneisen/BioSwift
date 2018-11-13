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
    
    public static func permutations(length: Int) -> [[Self.Base]] {
        return SequenceGenerator.permutations(of: Self.Base.all, length: length)
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
    
    /**
        Find indices that correspond to a spliced motif
        - parameter subSeq: the sequence whose indices are being searched for
        - returns: An Int array the size of subSeq. Each element represents where the
            corresponding character is found in the primary sequence.
    */
    public func splicedMotif(of subSeq: Self) -> [Int]? {
        // - sub sequence must be contained within the primary sequence
        guard subSeq.length < self.length else { return nil }
        
        var i = 0 // - sub sequence index
        var j = 0 // - primary sequence index
        var indices: [Int] = []
        while i < subSeq.length && j < self.length {
            defer { j += 1 }
            
            guard subSeq[i] == self[j] else { continue }
            
            indices.append(j)
            i += 1
        }
        // - result is valid only if all elements were found in order
        return indices.count == subSeq.length ? indices : nil
    }
}
