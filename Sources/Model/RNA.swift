import Foundation

public struct RNA {
    
    public let sequence: String
    
    //more efficient, less safe
    public init(validSequence: String){
        self.sequence = validSequence
    }
    
    //use this to ensure that a sequence is valid
    public init?(sequence: String ){
        
        let nucleotides = Set("ACGU".characters)
        self.sequence = String(sequence.characters.filter { nucleotides.contains($0) })
        if self.sequence.characters.count != sequence.characters.count {
            //string was invalid because there were non valid characters entered
            return nil
        }
    }
}
