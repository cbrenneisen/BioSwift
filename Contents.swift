//: Playground - noun: a place where people can play

import Foundation

func countNucleotides(){

    let d = DNA(sequence: "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")

    let result = BioService.nucleobaseCount(dna: d)
    let output = result.map{ String($0.1)}.joined(separator: " ")
    print(output)

}

func transcribeDNA(){
    
    let d = DNA(sequence: "GATGGAACTTGACTACGTAAATT")
    
    let r = BioService.transcribe(dna: d)
    print(r.sequence)
    
}

func reverseComplement(){
    
    let d = DNA(sequence: "AAAACCCGGT")
    
    let d2 = BioService.reverseComplement(dna: d)
    print(d2.sequence)
    
}

func fibonacci(){
    
    let result = MathService.fibonacci(n: 5, k: 3)
    print(result)
    
}

func gcContent(){
    
    let allDNA = FastaService.loadDNA(fastaFile: "fasta1")
    let dna = BioService.highestGCContent(dnaSequences: allDNA)
    if let d = dna {
        print(d.id!)
        print(d.gcContent)
    }
}

func pointMutations(){
    
    let dna1 = DNA(sequence: "GAGCCTACTAACGGGAT")
    let dna2 = DNA(sequence: "CATCGTAATGACGGCCT")
    
    let result = BioService.hammingDistance(dna1: dna1, dna2: dna2)
    print(result)
    
}

func mendelianInheritance(){
    
    let result = MathService.dominanceProbability(k: 2, m: 2, n: 2)
    print(result)
}

func translateRNA(){
    
    let rna = RNA(sequence: "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA")
    let protein = BioService.translate(rna: rna)
    if let p = protein {
        print(p.sequence)
    }
}

func motifs(){
    
    let baseDNA = DNA(sequence: "GATATATGCATATACTT")
    let subDNA = DNA(sequence: "ATAT")
    
    let motifIndices = BioService.motifLocations(baseDNA: baseDNA, subDNA: subDNA).map({String($0)}).joined(separator: " ")
    
    print(motifIndices)
    
}

func commonAncestor(){
    
    let allDNA = FastaService.loadDNA(fastaFile: "fasta2")
    let consensus = BioService.consensusDNA(allDNA: allDNA)
    
    if let c = consensus{
        print(c.sequence)
    }
    
    
}

countNucleotides()
transcribeDNA()
reverseComplement()
fibonacci()
gcContent()
pointMutations()
mendelianInheritance()
translateRNA()
motifs()
commonAncestor()
