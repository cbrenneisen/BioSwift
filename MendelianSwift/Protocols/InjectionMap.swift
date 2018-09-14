//
//  InjectionMap.swift
//  MendelianSwift
//
//  Created by mac on 9/12/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

final internal class InjectionMap{
    
    fileprivate static var fileReader: SequenceFileReader = BioSequenceFileReader()
    
    static func set(fileReader: SequenceFileReader){
        InjectionMap.fileReader = fileReader
    }
}

//MARK: - SequenceFileReader
public protocol SequenceFileReaderInjected { }

internal extension SequenceFileReaderInjected {
    
    /**
        The object's file reader
    */
    static var fileReader: SequenceFileReader {
        return InjectionMap.fileReader
    }
}

