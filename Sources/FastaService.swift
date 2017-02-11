//
//  FastaService.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//

import Foundation

public class FastaService {

    //reads in a FASTA file and returns an array of DNA objects
    public class func loadDNA(fastaFile: String) -> [DNA]{
        
        guard let filepath = Bundle.main.path(forResource: fastaFile, ofType: "txt") else {
            print("FASTA file not found")
            return []
        }
        
        do {
            let data = try String(contentsOfFile: filepath, encoding: .utf8)
            let lines = data.components(separatedBy: .newlines)
            
            var allDNA: [DNA] = []
            var currentID = ""
            var currentSeq = ""
            //iterate through entire file, line by line
            for line in lines {
                
                if String(line.characters.prefix(1)) == ">" {
                    //new DNA sequence

                    if (currentID != "" && currentSeq != ""){
                        //add previous
                        allDNA.append(DNA(sequence: currentSeq, id: currentID))
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
                allDNA.append(DNA(sequence: currentSeq, id: currentID))
            }
            
            return allDNA
        }catch {
            print("FASTA Parsing Error")
            return []
        }
    }
}
