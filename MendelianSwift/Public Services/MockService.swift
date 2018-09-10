//
//  MockService.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 3/9/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import Foundation

final public class MockService {
    
    public class func generateRandomDNA(minLength: Int, maxLength: Int, count: Int) ->Set<DNA> {
        
        var retVal = Set<DNA>()
        if minLength > maxLength || minLength < 0 || maxLength < 0 || count < 1 {
            //error handling
            return retVal
        }
        
//        for _ in 1...count {
//            let seq = generateRandomSequence(minLength: minLength, maxLength: maxLength, validCharacters: DNA.validCharacters())
//            retVal.insert(DNA(sequence: seq)!)
//        }
        return retVal
    }

    public class func generateRandomRNA(minLength: Int, maxLength: Int, count: Int) ->Set<RNA> {
        
        var retVal = Set<RNA>()
        if minLength > maxLength || minLength < 0 || maxLength < 0 || count < 1 {
            //error handling
            return retVal
        }
        
//        for _ in 1...count {
//            let seq = generateRandomSequence(minLength: minLength, maxLength: maxLength,
//                                             validCharacters: RNA.validCharacters())
//            retVal.insert(RNA(sequence: seq)!)
//        }
        return retVal
    }
    
    public class func generateRandomProtein(minLength: Int, maxLength: Int, count: Int) ->Set<Protein> {
        
        var retVal = Set<Protein>()
        if minLength > maxLength || minLength < 0 || maxLength < 0 || count < 1 {
            //error handling
            return retVal
        }
        
//        for _ in 1...count {
//            let seq = generateRandomSequence(minLength: minLength, maxLength: maxLength,
//                                             validCharacters: Protein.validCharacters())
//            retVal.insert(Protein(sequence: seq)!)
//        }
        return retVal
    }
    
    private class func generateRandomSequence(minLength: Int, maxLength: Int, validCharacters: Set<Character>) -> String {
        
        var sequence = ""
        let randomLength = Int(arc4random_uniform(UInt32((maxLength-minLength) + 1))) + minLength
        if (randomLength == 0){
            //we'll let the caller deal with this situation
            return ""
        }
        for _ in 1...randomLength {
            //randomly grab characters from the given set and append them to the sequence
            let randomIndex = Int(arc4random_uniform(UInt32(validCharacters.count)))
            let index = validCharacters.index(validCharacters.startIndex, offsetBy: randomIndex)
            sequence += String(validCharacters[index])
        }
        
        return sequence
    }
}
