//
//  Nucleobase+String.swift
//  MendelianSwift
//
//  Created by mac on 10/23/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

internal extension Array where Element: Nucleobase {
    
    internal var string: String {
        return self.map{ $0.string }.joined()
    }
    
    internal var characters: [Character] {
        return self.compactMap{ $0.string.first }
    }
}

internal extension Array {
    
    internal func printOutBases<T: Nucleobase>() where Element == [T] {
        forEach(){
            print( $0.map{ $0.string }.joined() )
        }
    }
}
