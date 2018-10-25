//
//  String+File.swift
//  MendelianSwift
//
//  Created by mac on 9/11/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

internal extension String {
    
    /**
     Create a string from a file
     - parameter file: The path of the file
    */
    internal init?(fromFile file: String){
        //var data: String?
        do {
            self = try String(contentsOfFile: file, encoding: .utf8)
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
