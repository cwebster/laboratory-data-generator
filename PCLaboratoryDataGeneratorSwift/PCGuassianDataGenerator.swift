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
    var valid = false
    var next = 0.0
    
    func rand_helper() -> Double {
        let time = Int(NSDate().timeIntervalSinceReferenceDate)
        srand48(time)
        let random_seed = drand48()
        return random_seed
    }
    
    
    func createDistribution() -> [[String:Double]] {
        // loops over number of tests to generate values
        
    }
    
    mutating func generateRandomNumber() -> Double {
        if self.valid == true {
            self.valid = false
            return next
        } else {
            self.valid = true
            let values = gaussian()
            next = values.x
            return values.y
        }
    }
    
    func gaussian() -> (x: Double, y: Double) {
        //
    }
    

}
