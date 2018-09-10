//
//  BioSequence.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/30/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.

import Foundation

public protocol BioSequence: Hashable {

    associatedtype Base: Nucleobase
    
    var sequence: [Base] { get }
    var sequenceString: String { get }
    
    var id: String? { get set }

    init(id: String?, sequence: [Base])
    
//    //needs to return valid characters for the given type (i.e: DNA returns A, C, G, T)
//    static func validCharacters()-> Set<Character>
}

//default implementations
public extension BioSequence {
    
    //MARK: - Initializers
    public init(sequence: [Base]) {
        self.init(id: nil, sequence: sequence)
    }
    
    public init?(id: String?, sequence: String) {
        guard let seq = Base.sequence(from: sequence) else {
            return nil
        }
        
        self.init(id: id, sequence: seq)
    }
    
    public init?(sequence: String){
        self.init(id: nil, sequence: sequence)
    }

    public var sequenceString: String {
        return sequence.map{ $0.string }.reduce("", +)
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.sequenceString == rhs.sequenceString
    }

    public var hashValue: Int {
        return sequenceString.hashValue
    }
    
    //returns the length of the sequence
    public var length: Int {
        return self.sequence.count
    }
    
    subscript (index: Int) -> Base {
        return sequence[index]
    }
    
    subscript (range: CountableRange<Int>) -> [Base] {
        return Array(sequence[range.lowerBound..<range.upperBound])
    }
    
    /**
     Returns the count of all bases in the DNA object
     */
    public var baseCount: [Base: Int] {
        return sequence.reduce(into: [Base: Int]()){
            $0[$1, default: 0] += 1
        }
    }
    
    /**
        Returns the starting index of all instances of the sub sequence
    */
    public func motifs(of subSeq: Self) -> [Int] {
        var locations: [Int] = []
        
        (0...(length-1)-subSeq.length).forEach(){ i in
    
            var match = true
            for (j, base2) in subSeq.sequence.enumerated() {
                // - make sure the bases are equal
                guard self[i+j] == base2 else {
                    match = false
                    break
                }
            }
            if match {
                locations.append(i)
            }
        }
        return locations
    }
    
//
//    //returns the subsequence starting with 'start' and ending with (and including) 'end'
//    public func getSubSequence(start: Int, end: Int) -> String {
//        let range = Range(start...end)
//        let startIndex = index(from: range.lowerBound)
//        let endIndex = index(from: range.upperBound)
//        return String(self.sequenceString[startIndex..<endIndex])
//    }

//    //helper function for the above
//    private func index(from: Int) -> String.Index {
//        return self.sequenceString.index(self.sequenceString.startIndex, offsetBy: from)
//    }
    
    public static func isValid(sequence: String) -> Bool {
        // go through every character and confirm that they can be converted
        for letter in sequence {
            if Base(from: letter) == nil {
                return false
            }
        }
        return true
    }
}


