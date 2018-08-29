//
//  Nucleobase.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 8/26/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public extension DNA {
    
    public enum Base: String, Nucleobase {
        
        case A = "adenine"
        case C = "cytosine"
        case G = "guanine"
        case T = "thymine"

        /**
            Creates a Nucleobase from a character
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
            Returns all Nucleobases for DNA
            TODO: - replace with Case Iterable in Swift 4.2
        */
        public static var all: [Base] {
            return [.A, .C, .G, .T]
        }
    }
}
