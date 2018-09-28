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
            
        // - F
        case (.U, .U, .U), (.U, .U, .C):
            self = .F
            
        // - L
        case (.U, .U, .A), (.U, .U, .G), (.C, .U, .U), (.C, .U, .C), (.C, .U, .A), (.C, .U, .G):
            self = .L
            
        // - S
        case (.U, .C, .U), (.U, .C, .A), (.U, .C, .G), (.U, .C, .C), (.A, .G, .U), (.A, .G, .C):
            self = .S
            
        // - Y
        case (.U, .A, .U), (.U, .A, .C):
            self = .Y
            
        // - C
        case (.U, .G, .U), (.U, .G, .C):
            self = .C
            
        // - W
        case (.U, .G, .G):
            self = .W

        // - P
        case (.C, .C, .U), (.C, .C, .C), (.C, .C, .A), (.C, .C, .G):
            self = .P
            
        // - H
        case (.C, .A, .U), (.C, .A, .C):
            self = .H

        // - Q
        case (.C, .A, .A), (.C, .A, .G):
            self = .Q
           
        // - R
        case (.C, .G, .U), (.C, .G, .C), (.C, .G, .A), (.C, .G, .G), (.A, .G, .A), (.A, .G, .G):
            self = .R
            
        // - I
        case (.A, .U, .U), (.A, .U, .C), (.A, .U, .A):
            self = .I
        
        // - M
        case (.A, .U, .G):
            self = .M
            
        // - T
        case (.A, .C, .U), (.A, .C, .C), (.A, .C, .A), (.A, .C, .G):
            self = .T
            
        // - N
        case (.A, .A, .U), (.A, .A, .C):
            self = .N
            
        // - K
        case (.A, .A, .A), (.A, .A, .G):
            self = .K
            
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
    
    /**
     Returns all possible origin codons for this amino acid
    */
    var originCodons: [Codon] {
        switch self {
            
        // - F
        case .F:
            return [(.U, .U, .U), (.U, .U, .C)]
            
        // - L
        case .L:
            return [(.U, .U, .A), (.U, .U, .G), (.C, .U, .U), (.C, .U, .C), (.C, .U, .A), (.C, .U, .G)]
            
        // - S
        case .S:
            return [(.U, .C, .U), (.U, .C, .A), (.U, .C, .G), (.U, .C, .C), (.A, .G, .U), (.A, .G, .C)]
            
        // - Y
        case .Y:
            return [(.U, .A, .U), (.U, .A, .C)]
            
        // - C
        case .C:
            return [(.U, .G, .U), (.U, .G, .C)]
            
        // - W
        case .W:
            return [(.U, .G, .G)]
            
        // - P
        case .P:
            return [(.C, .C, .U), (.C, .C, .C), (.C, .C, .A), (.C, .C, .G)]
            
        // - H
        case .H:
            return [(.C, .A, .U), (.C, .A, .C)]
            
        // - Q
        case .Q:
            return [(.C, .A, .A), (.C, .A, .G)]
            
        // - R
        case .R:
            return [(.C, .G, .U), (.C, .G, .C), (.C, .G, .A), (.C, .G, .G), (.A, .G, .A), (.A, .G, .G)]
            
        // - I
        case .I:
            return [(.A, .U, .U), (.A, .U, .C), (.A, .U, .A)]
            
        // - M
        case .M:
            return [(.A, .U, .G)]
            
        // - T
        case .T:
            return [(.A, .C, .U), (.A, .C, .C), (.A, .C, .A), (.A, .C, .G)]
            
        // - N
        case .N:
            return [(.A, .A, .U), (.A, .A, .C)]
            
        // - K
        case .K:
            return [(.A, .A, .A), (.A, .A, .G)]
            
        // - V
        case .V:
            return [(.G, .U, .U), (.G, .U, .C), (.G, .U, .A), (.G, .U, .G)]
            
        // - A
        case .A:
            return [(.G, .C, .U), (.G, .C, .C), (.G, .C, .A), (.G, .C, .G)]
            
        // - D
        case .D:
            return [(.G, .A, .U), (.G, .A, .C)]
            
        // - E
        case .E:
            return [(.G, .A, .A), (.G, .A, .G)]
            
        // - G
        case .G:
            return [(.G, .G, .U), (.G, .G, .C), (.G, .G, .A), (.G, .G, .G)]
        }
    }
}

extension AminoAcid {
    
    /**
     Returns the monoisotopic mass of the Amino Acid
     */
    var monoisotopicMass: Float{
        switch self {
        case .A:
            return 71.03711
        case .C:
            return 103.00919
        case .D:
            return 115.02694
        case .E:
            return 129.04259
        case .F:
            return 147.06841
        case .G:
            return 57.02146
        case .H:
            return 137.05891
        case .I:
            return 113.08406
        case .K:
            return 128.09496
        case .L:
            return 113.08406
        case .M:
            return 131.04049
        case .N:
            return 114.04293
        case .P:
            return 97.05276
        case .Q:
            return 128.05858
        case .R:
            return 156.10111
        case .S:
            return 87.03203
        case .T:
            return 101.04768
        case .V:
            return 99.06841
        case .W:
            return 186.07931
        case .Y:
            return 163.06333
        }
    }
}
