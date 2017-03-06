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
        
        //AGTCCAT - AGUCCAU
        let seq = String(dna.sequence.characters.map{ $0 != "T" ? $0 : "U" })
        //RNA is guaranteed to be valid - okay to force unrwrap
        return RNA(sequence: seq)!
        
    }
    
    //given a DNA strand, return the reverse complement
    public class func reverseComplement(dna: DNA) -> DNA {
        
        let complements = ["A": "T", "T": "A", "G": "C", "C": "G"]
        let seq = dna.sequence.characters.reversed().map({ complements[String($0)]! }).joined(separator: "")
        //guarenteed to work, so force unwrapping is fine
        return DNA(sequence: seq)!
    }
    
    //return the DNA with the highest GC content
    public class func highestGCContent(dnaSequences: [DNA]) -> DNA? {
        
        var maxGC: Float = 0.0
        var retval: DNA? = nil
        for var dna in dnaSequences {
            
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
            guard let codon = rna.codonFrom(index: n) else {
                //internal error - shouldn't happen - indicates that the sequenceLength is invalid
                return nil
            }
            
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
    
    //given a set of DNA strings, return a DNA sequence consisting of the most common base found in each position
    //restriction: each sequence must be the same length
    public class func consensusDNA(allDNA: [DNA]) -> DNA? {
        
        guard let length = allDNA.first?.sequenceLength else {
            return nil
        }
        
        let bases = Constants.dnaBases
        
        //initialize matrix for keeping track of occurrences
        var profile: [[Int]] = [[], [], [], []]
        
        for i in 0...bases.count-1 {
            //A, T, C, G
            for _ in 0...length-1 {
                //Initialize each base in the sequence
                profile[i].append(0)
            }
        }
        
        for dna in allDNA {
            
            if dna.sequenceLength != length {
                print("Consensus Error - Not all sequences are the same length")
                return nil
            }
            
            for index in 0...dna.sequenceLength-1 {
                
                let base = dna.getBase(index: index)
                
                switch(base){
                    case "A":
                        profile[0][index] += 1
                        break
                    case "T":
                        profile[1][index] += 1
                        break
                    case "C":
                        profile[2][index] += 1
                        break
                    case "G":
                        profile[3][index] += 1
                        break
                    default:
                        print("Consensus Error - Invalid base found:\(base)")
                        return nil
                }
            }
        }
        
        var consensusSeq = ""
        
        //create the consensus sequence
        for index in 0...length-1 {
            
            var consensusBase = "A"
            var consensusIndex = 0
            //find the most common occurrence
            for i in 1...3 {
                if (profile[consensusIndex][index] <= profile[i][index]){
                    //if new max, update

                    consensusIndex = i
                    switch (i){
                        case 1:
                            consensusBase = "T"
                            break
                        case 2:
                            consensusBase = "C"
                            break
                        case 3:
                            consensusBase = "G"
                            break
                        default:
                            consensusBase = "A"
                    }
                }
            }
            
            consensusSeq += consensusBase
        }
        
        if (Constants.debugMode){
            //output matrix
            for i in 0...bases.count-1 {
                
                let output = bases[i] + " " + profile[i].map({String($0)}).joined(separator: " ")
                print (output)
                
            }
        }
        
        return DNA(sequence: consensusSeq)
    }
    
    /* Overlaph Graph
       Returns the overlap graph for a collection of DNA strings
       -An overlap graph is a directed graph that creates an edge from sequence A to sequence B
            if there is a suffix in A that is equal to a prefix in B
       -The threshold specifies the minimum length to consider when creating an edge between sequences
     */
    public func overlapGraph(allDNA: [DNA], threshold: Int){
        
        for dnaA in allDNA {
            for dnaB in allDNA{
                
                //TODO: implement equality check in DNA
                if dnaA == dnaB {
                    continue
                }
                
                let left = String(dnaA.sequence.characters.suffix(threshold))
                let right = String(dnaB.sequence.characters.prefix(threshold))
                
                if left == right {
                    
                }
                
            }
        }
    }
}
