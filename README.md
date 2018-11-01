# MendelianSwift

A Protocol Oriented Framework that brings elegant Bioinformatics programming to Swift

# About

Admittedly, there are other libraries for Bioinformatics programming (such as BioPython) with huge communities behind them and years of feature development. What MendelianSwift offers is a safer and more elegant way of dealing with Bioinformatics problem thanks to the robust language features of Swift. Instead of dealing with error-prone raw strings and traditional OOP, we can now use type-safe enums and generics, along with a much more modular and composition based methodology.

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
  }  // "ACUGA"
```
That works for this given example, but what if we were to give a non-valid string like "ACRGX"? Not so much fun in that case. Now consider this framework, which will validate a sequence and minimize the opportunity for run time errors. 

```swift
  guard let dna = DNA(sequence: "ACTGA") else { return }
  
  let rna = dna.transcribed()  // "ACUGA"
```
In this case, we know that the DNA was successfully transcribed with 0 errors. Otherwise our initial guard statement would have failed due to invalid input. 

# Algorithms 

Coming soon
