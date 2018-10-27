//
//  BioGraphFactory.swift
//  MendelianSwift
//
//  Created by Carlos Brenneisen on 10/27/18.
//  Copyright © 2018 carlosbrenneisen. All rights reserved.
//

import Foundation

public class BioGraphFactory {
    
    public static func create<T: BioSequence>(_ type: T.Type, directed: Bool, weighted: Bool) -> BioGraph<T> {
        let sequences: [T] = []
        return selectGraph(with: sequences, directed: directed, weighted: weighted)
    }
    
    public static func create<T: BioSequence>(with sequences: Set<T>, directed: Bool, weighted: Bool) -> BioGraph<T>{
        return create(with: Array(sequences), directed: directed, weighted: directed)
    }
    
    public static func create<T: BioSequence>(with sequences: [T], directed: Bool, weighted: Bool) -> BioGraph<T>{
        return selectGraph(with: sequences, directed: directed, weighted: weighted)
    }
    
    private static func selectGraph<T: BioSequence>(with sequences: [T], directed: Bool, weighted: Bool) -> BioGraph<T> {
        switch (directed, weighted) {
        case (true, true):
            //TODO: take weighted into account
            return DirectedGraph<T>(sequences: sequences)
        case (true, false):
            return DirectedGraph<T>(sequences: sequences)
        case (false, true):
            //TODO: take weighted into account
            return UndirectedGraph<T>(sequences: sequences)
        case (false, false):
            return UndirectedGraph<T>(sequences: sequences)
        }
    }
}
