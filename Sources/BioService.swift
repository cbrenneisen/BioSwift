//
//  BioService.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/21/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//

import Foundation

public class BioService {
    
    //given a DNA strand, return a dictionary containing the count of each base
    public class func nucleobaseCount(dna: DNA) -> [String: Int]{
        
        //valid nucleobases
        var bases = ["A": 0, "C": 0, "G": 0, "T": 0]
        
        for n in dna.sequence.characters {
            
            guard let b = bases[String(n)] else {
                //nucleotide could potentially be invalid
                continue
            }
            //increment the count
            bases[String(n)] = b + 1
        }
        return bases
    }
    
    //given a DNA strand, return the transcribed RNA strand
    public class func transcribe(dna: DNA) -> RNA {
        
        let seq = String(dna.sequence.characters.map{ $0 != "T" ? $0 : "U" })
        return RNA(sequence: seq)
        
    }
    
    //given a DNA strand, return the reverse complement
    public class func reverseComplement(dna: DNA) -> DNA {
        
        let complements = ["A": "T", "T": "A", "G": "C", "C": "G"]
        let seq = dna.sequence.characters.reversed().map({ complements[String($0)]! }).joined(separator: "")
        return DNA(sequence: seq)
    }
    
    //return the DNA with the highest GC content
    public class func highestGCContent(dnaSequences: [DNA]) -> DNA? {
        
        var maxGC: Float = 0.0
        var retval: DNA? = nil
        for dna in dnaSequences {
            
            let gc = dna.gcContent
            maxGC = max(maxGC, gc)
            if maxGC == gc {
                retval = dna
            }
        }
        
        return retval
    }
 
    //return the number of different bases between two DNA strands
    public class func hammingDistance(dna1: DNA, dna2: DNA) -> Int {
    
        if (dna1.sequenceLength != dna2.sequenceLength) {
            //sequences need to be the same length
            return 0
        }
        
        var difference = 0
        for i in 0...dna1.sequenceLength-1 {
            if dna1.getBase(i: i) != dna2.getBase(i: i) {
                difference += 1
            }
        }
        
        return difference
    }
    
    public class func translate(rna: RNA) -> Protein? {

        var stopCodon = false
        var proteinSequence = ""
        for n in stride(from: 0, to: rna.sequenceLength, by: 3){
            
            let codon = rna.codonFrom(index: n)
            let amino = CodonTable.shared.codonToAminoAcid(codon: codon)
            
            guard let a = amino else {
                //invalid codon given
                return nil
            }
            
            if a == "Stop"{
                stopCodon = true
                break
            }
            proteinSequence += a
        }
        
        if !stopCodon {
            return nil
        }
        
        return Protein(sequence: proteinSequence)
    }
}




