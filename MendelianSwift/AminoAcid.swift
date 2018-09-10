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
    
    //MARK: - Protocol Requirements
    public static var all: [AminoAcid] {
        return [.A, .R, .N, .D, .C, .E, .Q, .G, .H, .I, .L, .K, .M, .F, .P, .S, .T, .W, .Y, .V]
    }
    
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
