//
//  Array+BioSequence.swift
//  MendelianSwift
//
//  Created by mac on 9/4/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

extension Array where Element: BioSequence {
    
    typealias BaseCounts = [Element.Base: Int]
    
    func getConsensusSequence() -> Element? {
        
        guard let length = first?.length else {
            print("Attempted to get consensus sequence of empty collection")
            return nil
        }
        
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
        
        consensus.debugCount()
        
        // - determine the number
        var sequence: [Element.Base] = []
        for count in consensus {
            // - get the highest occurring base
            guard let base = count.max(by: { $0.value < $1.value })?.key else {
                print("No valid occuring base in \(count)")
                return nil
            }
            sequence.append(base)
        }
        return Element(sequence: sequence)
    }
}

fileprivate extension Array {
    
    func debugCount<T: Nucleobase>() where Element == [T: Int] {
        
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
