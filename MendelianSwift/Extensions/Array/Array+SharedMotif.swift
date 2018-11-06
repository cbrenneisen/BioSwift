//
//  Array+SharedMotif.swift
//  MendelianSwift
//
//  Created by mac on 9/12/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension Array where Element: BioSequence {
    
    /**
     The longest common subsequence of all sequence objects
    */
    public var longestSharedMotif: Element? {
        
        guard let subject = last else { return nil }
        
        var left = 0
        var right = subject.length + 1
        
        while left + 1 < right {
            
            let mid = ((left + right) / 2)
            
            if let _ = commonSubstring(subject: subject, length: mid){
                left = mid
            }else{
                right = mid
            }
        }
        
        return commonSubstring(subject: subject, length: left)
    }

    /**
     The longest substring of the sequence that is found in the rest of the collection
     
     - parameter subject: The sequence for which to search for substrings
     - parameter length: the maximum length to search for
     
     - returns: the longest common subsequence, if one exists
    */
    private func commonSubstring(subject: Element, length: Int) -> Element? {
        
        for left in 0...(subject.length - length){
            
            let substring = subject[left..<left+length]
            
            var exists = true
            for d in self {
                if !d.sequence.contains(substring) {
                    exists = false
                    break
                }
            }
            if (exists){
                return Element(sequence: substring)
            }
        }
        return nil
    }
}
