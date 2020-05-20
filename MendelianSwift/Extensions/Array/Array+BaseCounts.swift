
//
//  Array.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 9/18/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

public extension Array where Element: BioSequence {
    
    /**
     Calculates the number of times a character occurs at a specified index across all sequences in the collection.
     All sequences must be the same length.
     - Returns: An array of dictionaries consisting of the number of times a character occurs at a specified index
    */
    func getBaseSums() -> [BaseCounts]? {
        
        // - make sure there is at least one sequence
        guard let length = first?.length else {
            print("Attempted to get consensus sequence of empty collection")
            return nil
        }
        
        // - initialize an empty dictionary for each position
        var consensus: [BaseCounts] = (0..<length).map{ _ in return Element.Base.counts }
        
        // - sum up the number of occurences for each base at each position
        for seq in self {
            // - verify length
            guard seq.length == length else {
                print("Attempted to get consensus sequence of collection where not all sequences are the same length")
                return nil
            }
            
            // - update consensus with bases from this sequence
            seq.sequence.enumerated().forEach(){ (j, base) in
                consensus[j][base, default: 0] += 1
            }
        }
        return consensus
    }
}
