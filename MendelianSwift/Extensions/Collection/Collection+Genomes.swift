//
//  Array+AssembleFragments.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 10/20/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public extension Collection where Element: BioSequence {
    
    /**
     Calculate the smallest possible super sequence of the array
     - Returns: The super sequence, if one exists
    */
    func assembleGenomes() -> Element? {
        
        // base case - an empty array has no super sequence
        guard count > 0 else { return nil }
        
        // base case - an array of one means the problem is already solved
        if count == 1 { return self.first }
        
        var overlaps = self.map{ $0.sequence }
        
        return Element(sequence: overlaps.shortestSuperSequence())
    }
}

fileprivate extension Array {
    
    /**
     Calculate the smallest possible super sequence of the array of bases
     - Returns: The super sequence
     */
    mutating func shortestSuperSequence<T: Nucleobase>()->[T] where Element == [T] {
       
        var length = count
        while length != 1 {
            var max = 0
            var indexL: Int?
            var indexR: Int?
            var resSeq: [T] = []
            
            (0..<length).forEach(){ i in
                ((i+1)..<length).forEach(){ j in
                    let result = self[i].maxOverlap(with: self[j])
                    
                    if max < result.0 {
                        max = result.0
                        resSeq = result.1
                        indexL = i
                        indexR = j
                    }
                }
            }
            length -= 1
            
            guard let l = indexL, let r = indexR else {
                // no overlap was found
                self[0] += self[length]
                continue
            }
            
            self[l] = resSeq
            self[r] = self[length]
        }
        return self[0]
    }
}
