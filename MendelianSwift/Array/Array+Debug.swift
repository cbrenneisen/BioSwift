//
//  Array+Debug.swift
//  MendelianSwift
//
//  Created by mac on 10/22/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

internal extension Array where Element == String {

    internal func printOut(){
        forEach(){
            print($0)
        }
    }
}
//
//internal extension Array where Element == BioSequence {
//
//    internal func printOut(){
//        print("Printing out sequences: ")
//        forEach(){
//            print($0.sequenceString)
//        }
//    }
//}
//
//internal extension Array {
//
//    internal func printBases<T: Nucleobase>() where Element == [T]{
//        print("Printing out sequences: ")
//        forEach() {
//            print($0.map{ $0.string } )
//        }
//    }
//}
//
//
//

internal extension Array where Element: Nucleobase {
    
    
//    internal var string: String {
//        return self.map{ $0.string }.joined()
//    }
}


//internal extension ArraySlice where Element: Nucleobase {
//
//    internal func printOut(){
//        print(self.map{ $0.string } )
//    }
//
//    internal var string: String {
//        return self.map{ $0.string }.joined()
//    }
//}
