//
//  Array+Contains.swift
//  MendelianSwift
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

internal extension Array where Element : Equatable {
    
    /**
     Check if this sequence contains the subsequence (in order)
     - parameter subsequence: The sub array to search for
     - returns: True if the sequence is found
     */
    internal func contains(_ subsequence: [Element]) -> Bool {
        return (index(of: subsequence) != nil)
    }
    
    /**
     Find the starting index of a sub array, in order
     - parameter subsequence: The sub array to search for
     - returns: The index of the sub array, if it is found
    */
    internal func index(of subsequence: [Element]) -> Int? {
        
        // - subsequence cannot be larger than the base array
        guard subsequence.count <= self.count else { return nil }
        
        for i in (0...self.count - subsequence.count) {
            if Array(self[i..<i+subsequence.count]) == subsequence {
                return i
            }
        }
        return nil
    }
}
