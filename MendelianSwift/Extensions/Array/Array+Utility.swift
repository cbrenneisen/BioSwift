//
//  Array+Utility.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 10/23/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

internal extension Array {
    
    /**
     Copy an array without the specified element
     - parameter index: The index of the element to remove
     - returns: a new array without the specified element
    */
    func without(_ index: Int) -> Array {
        var result = self
        _ = result.remove(at: index)
        return result
    }
}

internal extension Array where Element == String {
    
    /**
     Prints out the contents of an array to the console.
     Used for debugging
    */
    func printOut(){
        forEach(){
            print($0)
        }
    }
}

