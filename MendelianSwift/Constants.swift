import Foundation

public struct Constants {
    
    public static let debugMode = true
    
    public static let dnaBases = ["A", "C", "G", "T"]
    
}


extension Set {
    public func randomObject() -> Element? {
        let n = Int(arc4random_uniform(UInt32(self.count)))
        let index = self.index(self.startIndex, offsetBy: n)
        return self.count > 0 ? self[index] : nil
    }
}
