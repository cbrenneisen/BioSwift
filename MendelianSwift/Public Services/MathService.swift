//
//  MathService.swift
//  BioSwift
//
//  Created by Carlos Brenneisen on 01/22/17.
//  Copyright © 2017 CarlosBrenneisen. All rights reserved.
//
import Foundation

final public class MathService {
    
    // Standard fibonacci sequence
    public class func fibonacci(n: Int) -> Int {
        return fibonacci(n: n, k: 1)
    }
    
    // Fibonacci function where each generation can produce k new offspring (instead of just 1)
    public class func fibonacci(n: Int, k: Int) -> Int{
        
        switch(n){
            case 0:
                return 0
            
            case 1, 2:
                return 1
            
            default :
                break
        }
        
        var a = 1, b = 1, c = 1

        for _ in 2...n-1 {
            c = b
            b = (b + (a * k))
            a = c
        }
        return b
    }
    
    
    //returns the probability that 2 random offspring from k + m + n will produce an offspring
    //with the dominant allele
    //k = homozygous, m = heterozygous, n = homozygous recessive 
    public class func dominanceProbability(k: Int, m: Int, n: Int) -> Float {
        
        let fK = Float(k)
        let fM = Float(m)
        let fN = Float(n)
        
        let population = fK + fM + fN
        
        //probability of the first organism being k, m, or n
        let probK = fK / population  //in this case: offspring always has dominant allele
        let probM = fM / population
        let probN = fN / population
    
        //probabilities of mk, mm, mn
        let probMK = probM * (fK / (population-1.0))
        let probMM = probM * ((fM-1.0) / (population-1.0))
        let probMN = probM * (fN / (population-1))
        
        //probabilities of nm, nk
        let probNM = probN * (fM / (population-1.0))
        let probNK = probN * (fK / (population-1.0))
        
        let totalK  = probK + probMK + probNK
        let totalMM = probMM * 0.75
        let totalMN = probMN * 0.5
        let totalNM = probNM * 0.5
        
        let result = totalK + totalMM + totalMN + totalNM
        return result
    }
}
