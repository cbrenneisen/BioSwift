//
//  TestSequenceFileReader.swift
//  MendelianSwiftTests
//
//  Created by Carl Brenneisen on 9/12/18.
//  Copyright © 2018 carlbrenneisen. All rights reserved.
//

import Foundation
@testable import MendelianSwift

final class TestSequenceFileReader: SequenceFileReader {
    
    lazy var bundle: Bundle = Bundle(for: type(of: self))
}
