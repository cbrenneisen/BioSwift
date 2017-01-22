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
        return RNA(validSequence: seq)
        
    }
    
    //given a DNA strand, return the reverse complement
    public class func reverseComplement(dna: DNA) -> DNA {
        
        let complements = ["A": "T", "T": "A", "G": "C", "C": "G"]
        let seq = dna.sequence.characters.reversed().map({ complements[String($0)]! }).joined(separator: "")
        return DNA(validSequence: seq)
        
    }
    
}
