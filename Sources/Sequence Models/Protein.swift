import Foundation

public class Protein: BioSequence {
    
    //valid characters are A-Z except B,J,O,U,X,Z
    override internal func validSequenceCharacters() -> Set<Character> {
        return Set("ACDEFGHIKLMNPQRSTVWY".characters)
    }
}
