//
//  MendelianTestCase.swift
//  MendelianSwiftTests
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import XCTest
@testable import MendelianSwift

class MendelianTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        InjectionMap.set(fileReader: TestSequenceFileReader())
        InjectionMap.set(debugMode: true)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension MendelianTestCase {
    
    func XCTAssert<T>(_ item: T, existsIn set: Set<T>){
        
    }
}
