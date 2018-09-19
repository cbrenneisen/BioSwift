//
//  RNA+Base.swift
//  MendelianSwift
//
//  Created by mac on 8/27/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public typealias Codon = (RNA.Base, RNA.Base, RNA.Base)

public extension RNA {
    
    public enum Base: String, Nucleobase {
     
        case A = "adenine"
        case C = "cytosine"
        case G = "guanine"
        case U = "uracil"
        
        /**
         Returns all Nucleobases for RNA
         TODO: - replace with Case Iterable in Swift 4.2
        */
        public static var all: [RNA.Base] {
            return [.A, .C, .G, .U]
        }
        
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
            case "U":
                self = .U
            default:
                return nil
            }
        }
    }
}
