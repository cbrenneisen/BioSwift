# MendelianSwift

A Protocol Oriented Framework to aid Bioinformatics programming in Swift

# About

Yes, there are other libraries for Bioinformatics programming (such as BioPython) with huge communities behind them and years of feature development. What MendelianSwift offers is a safer and more elegant way of dealing with Bioinformatics problem thanks to the robust language features of Swift. Instead of dealing with error-prone raw strings and traditional OOP, we can now use type-safe enums and generics, along with a much more modular and composition based methodology.

# Example

Consider trascribing a string that represents a strand of DNA. 
```swift
  let dna = "ACTGA"
  rna = dna.map {
    switch $0{
      case "T":
        return "U"
      default: 
        return $0
    }
  }
  // rna = "ACUGA"
```
That works for this given example, but what if we were to give a non-valid string like "ACRGX"? Not so much fun in that case. Now consider using an enum, like this framework does:
```swift
public extension DNA {
    
    public enum Base: String, Nucleobase {
        
        case A = "adenine"
        case C = "cytosine"
        case G = "guanine"
        case T = "thymine"
        
        public var transcribed: RNA.Base {
            switch self {
            case .A:
                return .A
            case .C:
                return .C
            case .G:
                return .G
            case .T:
                return .U
            }
        }
// there's more code than that, but you get the idea
```
Now we can define what the appropriate transcribed character should be (another enum) and make more powerful assertions about our code, so that when we do something like this: 
```swift
  guard let dna = DNA(sequence: "ACTGA") else { return }
  
  let rna = dna.transcribed()  // "ACUGA"
```
We know that the DNA was successfully transcribed with 0 errors. Otherwise our initial guard statement would have failed due to invalid input. 







