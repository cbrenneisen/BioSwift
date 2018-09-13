//
//  TestSequenceFileReader.swift
//  MendelianSwiftTests
//
//  Created by mac on 9/12/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation
@testable import MendelianSwift

final class TestSequenceFileReader: SequenceFileReader {
    
    lazy var bundle: Bundle = Bundle(for: type(of: self))
}
