//
//  SequenceGenerator.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 10/6/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

final internal class SequenceGenerator {
    
    class func permutations(of alphabet: [Character], length: Int) -> [String]{
        //TODO: - finish this
        //start with first char - find all permutations where every other char is the next one
        var allPermutations: [String] = []
//        alphabet.enumerated().forEach(){ i, val in
//            let minus = 
//            let alpha = alphabet - [$0]
//            allPermutations += permutations(of: alphabet, using: [$0], length: length)
//        }
        return []
    }
    
    private class func permutations(of alphabet: [Character], using seq: [Character], length: Int) -> [String]{
        return []
    }
}
