//: Playground - noun: a place where people can play

import Cocoa


//
//  PCGuassianDataGenerator.swift
//  PCLaboratoryDataGeneratorSwift
//
//  Created by Webster Craig on 24/08/2016.
//  Copyright © 2016 Webster Craig. All rights reserved.
//

import Foundation

struct PCGaussianData {
    var mean: Double
    var standardDeviation: Double
    var numResultsRequired: Int
    private var valid = false
    private var next = 0.0
    
    init(mean: Double, standardDeviation: Double, numResultsRequired: Int) {
        self.mean   = mean
        self.standardDeviation = standardDeviation
        self.numResultsRequired  = numResultsRequired
    }
    
    mutating func createDistribution() -> [Int:Double] {
        var results = [Int:Double]()
        
        for index in 1...numResultsRequired {
            results[index] = generateRandomNumber()
            print("\(index) result is \(results[index])")
        }
        return results
    }
    
    private mutating func generateRandomNumber() -> Double {
        if valid == true {
            valid = false
            return next
        } else {
            valid = true
            let values = gaussian()
            next = values.y
            return values.x
        }
    }
    
    private func gaussian() -> (x: Double, y: Double) {
        let x = mean + scale(rho()) * thetaCos(theta(piFactor()))
        let y = mean + scale(rho()) * thetaSin(theta(piFactor()))
        return (x,y)
    }
    
    private func piFactor() -> Double {
        return 2 * M_PI
    }
    
    private func theta(piFactor:Double) -> Double {
        return piFactor * drand48()
    }
    
    private func rho() -> Double {
        return sqrt((-2 * log(1-drand48())))
    }
    
    private func scale(rho: Double) -> Double {
        return standardDeviation * rho
    }
    
    private func thetaCos(theta: Double) -> Double {
        return cos(theta)
    }
    
    private func thetaSin(theta: Double) -> Double {
        return sin(theta)
    }
    
    
}


var results = PCGaussianData(mean: 100, standardDeviation: 0.1, numResultsRequired: 100)
print(results)


results.piFactor()
results.generateRandomNumber()
results.gaussian()





