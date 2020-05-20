//
//  Nucleobase+String.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 10/23/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

internal extension Array where Element: Nucleobase {
    
    var string: String {
        return self.map{ $0.string }.joined()
    }
    
    var characters: [Character] {
        return self.compactMap{ $0.string.first }
    }
}

internal extension Array {
    
    func printOutBases<T: Nucleobase>() where Element == [T] {
        forEach(){
            print( $0.map{ $0.string }.joined() )
        }
    }
}
