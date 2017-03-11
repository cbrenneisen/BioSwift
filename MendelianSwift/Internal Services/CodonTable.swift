import Foundation

internal class CodonTable {
    
    static let shared = CodonTable()
    
    private init(){}
    
    //returns the amino acid that corresponds to an amino acid
    public func codonToAminoAcid(codon: String) -> String?{
        return table[codon]
    }
    
    //returns all possible codons that correspond to an amino acid
    public func aminoAcidToCodons(aminoAcid: String) -> [String]? {
        return reversedTable[aminoAcid]
    }
    
    private lazy var reversedTable: [String: [String]] = {
        var result: [String: [String]] = [:]
        
        for (k,v) in self.table {
            
            var list: [String]
            if result[v] == nil {
                list = []
            }else{
                list = result[v]!
            }
            
            list.append(k)
            result[v] = list
        }
        return result
    }()
    
    private lazy var table: [String: String] = {
        return  ["UUU": "F",
                 "CUU": "L",
                 "AUU": "I",
                 "GUU": "V",
                 "UUC": "F",
                 "CUC": "L",
                 "AUC": "I",
                 "GUC": "V",
                 "UUA": "L",
                 "CUA": "L",
                 "AUA": "I",
                 "GUA": "V",
                 "UUG": "L",
                 "CUG": "L",
                 "AUG": "M",
                 "GUG": "V",
                 "UCU": "S",
                 "CCU": "P",
                 "ACU": "T",
                 "GCU": "A",
                 "UCC": "S",
                 "CCC": "P",
                 "ACC": "T",
                 "GCC": "A",
                 "UCA": "S",
                 "CCA": "P",
                 "ACA": "T",
                 "GCA": "A",
                 "UCG": "S",
                 "CCG": "P",
                 "ACG": "T",
                 "GCG": "A",
                 "UAU": "Y",
                 "CAU": "H",
                 "AAU": "N",
                 "GAU": "D",
                 "UAC": "Y",
                 "CAC": "H",
                 "AAC": "N",
                 "GAC": "D",
                 "UAA": "Stop",
                 "CAA": "Q",
                 "AAA": "K",
                 "GAA": "E",
                 "UAG": "Stop",
                 "CAG": "Q",
                 "AAG": "K",
                 "GAG": "E",
                 "UGU": "C",
                 "CGU": "R",
                 "AGU": "S",
                 "GGU": "G",
                 "UGC": "C",
                 "CGC": "R",
                 "AGC": "S",
                 "GGC": "G",
                 "UGA": "Stop",
                 "CGA": "R",
                 "AGA": "R",
                 "GGA": "G",
                 "UGG": "W",
                 "CGG": "R",
                 "AGG": "R",
                 "GGG": "G"]
    }()
}
