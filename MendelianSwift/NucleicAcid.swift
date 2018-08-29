//
//  NucleicAcid.swift
//  MendelianSwift
//
//  Created by mac on 8/29/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public protocol NucleicAcid: BioSequence {
    
    associatedtype Base: Nucleobase
    var bases: [Base] { get }
}

extension NucleicAcid {
    public var bases: [Base] {
        return sequence.map{ Base(unsafeFrom: $0) }
    }

//    public init?(sequence: String){
//        for letter in sequence {
//            if Base(from: letter) == nil {
//                return nil
//            }
//        }
//        self.init(id: nil, sequence: sequence)
//    }

    /**
        Determines whether a given string is valid for the Sequence Type
    */
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
