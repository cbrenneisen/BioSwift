//
//  AminoAcid.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 9/2/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public enum AminoAcid: String, Nucleobase {
    
    //MARK: - Cases
    
    case A = "Alanine"
    case R = "Arginine"
    case N = "Asparagine"
    case D = "Aspartic Acid"
    case C = "Cysteine"
    case E = "Glutamic acid"
    case Q = "Glutamine"
    case G = "Glycine"
    case H = "Histidine"
    case I = "Isoleucine"
    case L = "Leucine"
    case K = "Lysine"
    case M = "Methionine"
    case F = "Phenylalanine"
    case P = "Proline"
    case S = "Serine"
    case T = "Threonine"
    case W = "Tryptophan"
    case Y = "Tyrosine"
    case V = "Valine"
    
    public init?(from char: Character) {
        switch char {
        case "A":
            self = .A
        case "R":
            self = .R
        case "N":
            self = .N
        case "D":
            self = .D
        case "C":
            self = .C
        case "E":
            self = .E
        case "Q":
            self = .Q
        case "G":
            self = .G
        case "H":
            self = .H
        case "I":
            self = .I
        case "L":
            self = .L
        case "K":
            self = .K
        case "M":
            self = .M
        case "F":
            self = .F
        case "P":
            self = .P
        case "S":
            self = .S
        case "T":
            self = .T
        case "W":
            self = .W
        case "Y":
            self = .Y
        case "V":
            self = .V
        default:
            return nil
        }
    }
}


extension AminoAcid {

    /**
        Create an Amino Acid from a Codon. Returns nil if given a STOP codon
        - parameter codon: The codon to convert to an Amino Acid
    */
    init?(from codon: Codon) {
        
        switch codon {
            
        //MARK: F
        case (.U, .U, .U), (.U, .U, .C):
            self = .F
            
        // MARK: L
        case (.U, .U, .A), (.U, .U, .G), (.C, .U, .U), (.C, .U, .C), (.C, .U, .A), (.C, .U, .G):
            self = .L
            
        // MARK: S
        case (.U, .C, .U), (.U, .C, .A), (.U, .C, .G), (.U, .C, .C):
            self = .S
            
        // MARK: Y
        case (.U, .A, .U), (.U, .A, .C):
            self = .Y
            
        //MARK: C
        case (.U, .G, .U), (.U, .G, .C):
            self = .C
            
        //MARK: W
        case (.U, .G, .G):
            self = .W

        // MARK: P
        case (.C, .C, .U), (.C, .C, .C), (.C, .C, .A), (.C, .C, .G):
            self = .P
            
        // MARK: H
        case (.C, .A, .U), (.C, .A, .C):
            self = .H

        //MARK: Q
        case (.C, .A, .A), (.C, .A, .G):
            self = .Q
           
        //MARK: R
        case (.C, .G, .U), (.C, .G, .C), (.C, .G, .A), (.C, .G, .G), (.A, .G, .A), (.A, .G, .G):
            self = .R
            
        //MARK: I
        case (.A, .U, .U), (.A, .U, .C), (.A, .U, .A):
            self = .I
        
        //MARK: M
        case (.A, .U, .G):
            self = .M
            
        //MARK: T
        case (.A, .C, .U), (.A, .C, .C), (.A, .C, .A), (.A, .C, .G):
            self = .T
            
        //MARK: N
        case (.A, .A, .U), (.A, .A, .C):
            self = .N
            
        // - K
        case (.A, .A, .A), (.A, .A, .G):
            self = .K
            
        // - S
        case (.A, .G, .U), (.A, .G, .C):
            self = .S
            
        // - V
        case (.G, .U, .U), (.G, .U, .C), (.G, .U, .A), (.G, .U, .G):
            self = .V
        
        // - A
        case (.G, .C, .U), (.G, .C, .C), (.G, .C, .A), (.G, .C, .G):
            self = .A
        
        // - D
        case (.G, .A, .U), (.G, .A, .C):
            self = .D
            
        // - E
        case (.G, .A, .A), (.G, .A, .G):
            self = .E
            
        // - G
        case (.G, .G, .U), (.G, .G, .C), (.G, .G, .A), (.G, .G, .G):
            self = .G
        
        // - STOP
        case (.U, .A, .A), (.U, .A, .G), (.U, .G, .A):
            return nil
        }
    }
    
}




