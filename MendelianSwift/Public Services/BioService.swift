//
//  BioService.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/21/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//

import Foundation

final public class BioService {
    
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
        
        let bases = Array(DNA.validCharacters())
        
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
        
        if (MendelConstants.debugMode){
            //output matrix
            for i in 0...bases.count-1 {
                
                let output = String(bases[i]) + " " + profile[i].map({String($0)}).joined(separator: " ")
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
    public class func overlapGraph(allDNA: [DNA], threshold: Int) -> BioGraph<DNA>{
        
        //key:   each unique prefix
        //value: an array of each vertex that begins with the given key
        var prefixToVertices: [String: [Vertex<DNA>]] = [:]
        
        //create vertices and populate dictionary
        let graph = BioGraph<DNA>()
        for dna in allDNA {
            //add a vertex for this sequence in the graph
            let vertex = graph.createVertex(bioSequence: dna)
            
            //add to the list of all vertices that begin with this prefix
            let left = String(dna.sequence.characters.prefix(threshold))
            if let _ = prefixToVertices[left] {
                prefixToVertices[left]!.append(vertex)
            }else{
                prefixToVertices[left] = [vertex]
            }
        }
        
        //create edges based on the suffix of the sequences
        let vertices = graph.getAllVertices()
        for vertex in vertices {
            //check if the right end of this sequence matches the left end of any sequence
            let right = String(vertex.bioSequence.sequence.characters.suffix(threshold))
            if let matches = prefixToVertices[right] {
                //there are some matches
                for m in matches {
                    if m != vertex {
                        //add the edge
                        graph.addEdge(fromVertex: vertex, toVertex: m)
                    }
                }
            }
        }
        
        return graph
    }
    
    //returns the longest common subsequence of all given DNA
    public class func longestSharedMotif(allDNA: [DNA]) -> String? {
        
        guard let subjectDNA = allDNA.last else {
            return ""
        }
        
        var left = 0
        var right = subjectDNA.sequenceLength + 1
        
        while left + 1 < right {
            
            let mid = ((left + right) / 2)
            
            if let _ = commonSubstring(subjectDNA: subjectDNA, allDNA: allDNA, length: mid){
                left = mid
            }else{
                right = mid
            }
        }
        
        return commonSubstring(subjectDNA: subjectDNA, allDNA: allDNA, length: left)
    }
    
    //helper function for the above method
    private class func commonSubstring(subjectDNA: DNA, allDNA: [DNA], length: Int) -> String?{
        
        for left in 0...(subjectDNA.sequenceLength - length + 1){
            
            let substring = subjectDNA.getSubSequence(start: left, end: left+length)
            
            var exists = true
            for d in allDNA {
                
                if !d.sequence.contains(substring) {
                    exists = false
                    break
                }
            }
            if (exists){
                return substring
            }
        }
        return nil
    }
    
    //TODO: should this accept Strings or DNA objects - and is this the most efficient way to do this?
    public class func splice(dna: DNA, introns: [String]) -> Protein? {
    
        var exons = dna.sequence
        for intron in introns {
            
            guard let range =  exons.range(of: intron) else{
                //intron is not found - could mean invalid intron sequence
                return nil
            }
            exons = exons.replacingOccurrences(of: intron, with: "", options: .literal, range: range)
        }
        
        guard let spliced = DNA(sequence: exons) else {
            return nil
        }
        
        let protein = translate(rna: transcribe(dna: spliced))
        return protein
    }
    
    public class func splicedMotif(dna: DNA, motif: DNA) -> (Int, Int, Int)?{
        
        var x = 0
        var y = 0
        var z = 0

        for i in 0...dna.sequenceLength-1   {
            
            if x == 0 {
                if dna.getBase(index: i) == motif.getBase(index: 0) {
                    x = i + 1
                }
            }
            else if y == 0 {
                if dna.getBase(index: i) == motif.getBase(index: 1) {
                    y = i + 1
                }
            }
            else {
                if dna.getBase(index: i) == motif.getBase(index: 2) {
                    z = i + 1
                    break
                }
            }
        }
        if z != 0 {
            //if we found all characters, return the correct indices
            return (x, y, z)
        }
        return nil
    }
    
}


