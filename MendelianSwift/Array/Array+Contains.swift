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
     Returns true if this sequence contains the subsequence (in order)
     - parameter subsequence: The sub array to search for
     */
    func contains(_ subsequence: [Element]) -> Bool {
        return (index(of: subsequence) != nil)
    }
    
    /**
     Returns the starting index of a subsequence, in order, if one exists
     - parameter subsequence: The sub array to search for
    */
    func index(of subsequence: [Element]) -> Int? {
        
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
