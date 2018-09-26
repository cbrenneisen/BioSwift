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
         Returns the equivalent RNA nucleobase
        */
        public var transcribed: RNA.Base {
            switch self {
            case .A:
                return .A
            case .C:
                return .C
            case .G:
                return .G
            case .T:
                return .U
            }
        }

        /**
         The complement of the base
        */
        public var complement: DNA.Base {
            switch self {
            case .A:
                return .T
            case .T:
                return .A
            case .G:
                return .C
            case .C:
                return .G
            }
        }
    }
}
