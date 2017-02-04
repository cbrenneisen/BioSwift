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
            if dna1.getBase(index: i) != dna2.getBase(index: i) {
                difference += 1
            }
        }
        
        return difference
    }
    
    //translate an RNA sequence into a protein sequence
    public class func translate(rna: RNA) -> Protein? {

        var stopCodon = false
        var proteinSequence = ""
        for n in stride(from: 0, to: rna.sequenceLength, by: 3){
            
            //get the current codon
            let codon = rna.codonFrom(index: n)
            
            guard let amino = CodonTable.shared.codonToAminoAcid(codon: codon) else {
                //invalid codon given
                return nil
            }
            
            if amino == "Stop"{
                //end of sequence
                stopCodon = true
                break
            }
            proteinSequence += amino
        }
        
        if !stopCodon {
            //invalid sequence - there must be a stop codon
            return nil
        }
        
        return Protein(sequence: proteinSequence)
    }
    
    //returns the starting index of all locations of subDNA found in baseDNA
    public class func motifLocations(baseDNA: DNA, subDNA: DNA) -> [Int] {
        
        var locations: [Int] = []
        for i in 0...baseDNA.sequenceLength-1{
            
            //get the current base of baseDNA

            var match = true
            for j in 0...subDNA.sequenceLength-1 {
                
                //check 1 by 1 if there is an occurrence of subDNA
                let amino1 = baseDNA.getBase(index: i+j)
                let amino2 = subDNA.getBase(index: j)
                
                if amino1 != amino2 {
                    match = false
                    break
                }
            }
            
            if (match){
                locations.append(i)
            }
        }
        
        return locations
    }
}




