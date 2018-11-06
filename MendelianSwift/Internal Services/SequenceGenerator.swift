//
//  SequenceGenerator.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 10/6/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

final internal class SequenceGenerator {
    
    static func permutations(of alphabet: String, length: Int, using seed: String = "") -> [String] {
        
        let strings: [Character] = alphabet.map{ $0 }
        let input: [Character] = seed.map{ $0 }
        return permutations(of: strings, length: length, using: input).map{ String($0) }
    }
    
    
    static func permutations<T>(of alphabet: [T], length: Int, using seed: [T] = []) -> [[T]] {
        if seed.count == length { return [seed] }
        var result: [[T]] = []
        alphabet.enumerated().forEach(){ i, val in
            let current = seed + [val]
            result += permutations(of: alphabet, length: length, using: current)
        }
        return result
    }
}
