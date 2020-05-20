//
//  InjectionMap.swift
//  MendelianSwift
//
//  Created by Carl Brenneisen on 9/12/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation

final internal class InjectionMap{
    
    private(set) static var debugMode: Bool = false
    fileprivate static var fileReader: SequenceFileReader = BioSequenceFileReader()
    
    static func set(fileReader: SequenceFileReader){
        InjectionMap.fileReader = fileReader
    }
    
    static func set(debugMode: Bool){
        InjectionMap.debugMode = debugMode
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

