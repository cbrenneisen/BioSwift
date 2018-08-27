//
//  Nucleobase.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 8/26/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension DNA {
    
    public enum Base: String {
        
        case A = "adenine"
        case C = "cytosine"
        case G = "guanine"
        case T = "thymine"
        
        /**
            Creates a Nucleobase from a string
        */
        public init?(from char: String) {
            // - only strings of length one should be accepted
            guard char.count == 1, let base = char.first else {
                return nil
            }
            self.init(from: base)
        }
        
        /**
            Creates a Nuceobase from a character
        */
        public init?(from char: Character){
            switch char {
            case "A":
                self = .A
            case "C":
                self = .C
            case "G":
                self = .G
            case "T":
                self = .T
            default:
                return nil
            }
        }
        
        /**
         Creates a Nuceobase from a character with no validation checks
        */
        internal init(unsafeFrom char: Character){
            switch char {
            case "A":
                self = .A
            case "C":
                self = .C
            case "G":
                self = .G
            case "T":
                self = .T
            default:
                fatalError("Invalid Nucleobase Given")
            }
        }
        
        /**
            Returns all Nucleobases for DNA
            TODO: - replace with Case Iterable in Swift 4.2
        */
        static var all: [Base] {
            return [.A, .C, .G, .T]
        }
    }
}
