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
    if var d = dna {
        print(d.id!)
        print(d.gcContent)
    }
}

countNucleotides()
transcribeDNA()
reverseComplement()
fibonacci()
gcContent()
