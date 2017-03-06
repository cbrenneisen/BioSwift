//
//  FastaService.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//

import Foundation

public enum FastaError: Error {
    
    case missingFile(file: String)
    case parsingError
    case invalidSequence(seq: String)
}

public class FastaService {

    //reads in a FASTA file and returns an array of DNA objects
    public class func loadDNA(fastaFilePath: String) throws -> [DNA]{
        
        var data: String?
        do {
            data = try String(contentsOfFile: fastaFilePath, encoding: .utf8)
        }catch{
            throw FastaError.missingFile(file: fastaFilePath)
        }
        
        guard let lines = data?.components(separatedBy: .newlines) else {
            throw FastaError.parsingError
        }
        
        var allDNA: [DNA] = []
        var currentID = ""
        var currentSeq = ""
        
        //iterate through entire file, line by line
        for line in lines {
                
            if String(line.characters.prefix(1)) == ">" {
                //new DNA sequence

                if (currentID != "" && currentSeq != ""){
                    //add previous
                    guard let curDNA = DNA(id: currentID, sequence: currentSeq) else {
                        //file has an invalid DNA sequence
                        throw FastaError.invalidSequence(seq: currentSeq)
                    }
                    allDNA.append(curDNA)
                }
                    
                //reset sequence, add ID without the preceding '>'
                currentSeq = ""
                currentID = String(line.characters.suffix(line.characters.count-1))
            }else{
                //add onto current DNA sequence
                currentSeq += line
            }
        }
        if (currentID != "" && currentSeq != ""){
            //add final strand - unless we had an empty file
            guard let curDNA = DNA(id: currentID, sequence: currentSeq) else {
                //file has an invalid DNA sequence
                throw FastaError.invalidSequence(seq: currentSeq)
            }
            allDNA.append(curDNA)
        }
        return allDNA
    }
}
