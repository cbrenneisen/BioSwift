//
//  Array+Overlap.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 10/22/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

internal extension Array where Element: Nucleobase {
    
    /**
     Calculates the smallest possible super sequence of this and another sequence
     - parameter other: The sequence to compare against
     
     - returns: A tuple where element 0 is the length of the overlap 
                and element 1 is the combined sequence using this overlap
    */
    func maxOverlap(with other: [Element]) -> (Int, [Element]) {
        
        var max = Int.min
        var result: [Element] = []
        
        self.suffix(with: other, max: &max, result: &result)
        other.suffix(with: self, max: &max, result: &result)
        
        return (max, result)
    }
    
    private func suffix(with other: [Element], max: inout Int, result: inout [Element]){

        // iterate until we check all characters of the smaller sequence
        let length = Swift.min(self.count, other.count)
        for i in 1..<length {

            guard self[count-i..<count] == other[0..<Swift.min(i, other.count)] else {
                // proceed if the end of the left matches the beginning of the right
                continue
            }
            guard max < i else {
                // only update if we have a new max
                continue
            }
            
            // return the max overlap and the combined sequence
            max = i
            result = self + other[i..<other.count]
        }
    }
}
