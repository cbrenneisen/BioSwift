//
//  Array+BioSequence.swift
//  MendelianSwift
//
//  Created by mac on 9/4/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension Array where Element: BioSequence {
    
    public typealias BaseCounts = [Element.Base: Int]
    
    /**
     Returns a valid consensus sequence for the given array, if one exists
    */
    func getConsensusSequence() -> Element? {
        
        // - get the number of times a base occurs at each index
        guard let consensus = getBaseSums() else { return nil }
        
        consensus.debugCount()
        
        // - get a valid sequence for the given base counts
        return consensus.getSequence()
    }
}

public extension Array {
    
    /**
     Returns a valid consensus sequence for the list of base counts, if one exists
    */
    public func getSequence<T: BioSequence>() -> T? where Element == [T.Base: Int]{
        var sequence: [T.Base] = []
        for count in self {
            // - get the highest occurring base
            guard let base = count.max(by: { $0.value < $1.value })?.key else {
                print("No valid occuring base in \(count)")
                return nil
            }
            sequence.append(base)
        }
        return T(sequence: sequence)
    }
    
    /**
     Prints out a table with the number of occurences of each character based on the base counts of the array
    */
    fileprivate func debugCount<T: Nucleobase>() where Element == [T: Int] {
        guard InjectionMap.debugMode else { return }
        
        // - begin each string with the name of the base
        var strings: [T: [String]] = T.all.reduce(into: [T: [String]]()){
            $0[$1] = Array<String>()
        }
        
        forEach(){ counts in
            T.all.forEach(){
                strings[$0]?.append(String(counts[$0, default: 0]))
            }
        }
        strings.sorted(by: { $0.key.string < $1.key.string}).forEach(){
            let output = "\($0.key.string): \($0.value.joined(separator: " "))"
            print(output)
        }
    }
}
