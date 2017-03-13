//
//  Utility.swift
//  MendelianSwift
//
//  Created by carlos.brenneisen on 3/13/17.
//  Copyright © 2017 carlosbrenneisen. All rights reserved.
//

import UIKit

class Utility {
    
    class func byChance() -> Bool {
        if (Int(arc4random_uniform(UInt32(10))) == 1){
            return true
        }
        return false
    }
}
