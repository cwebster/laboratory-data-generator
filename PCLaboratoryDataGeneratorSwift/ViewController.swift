//
//  ViewController.swift
//  PCLaboratoryDataGeneratorSwift
//
//  Created by Webster Craig on 23/08/2016.
//  Copyright © 2016 Webster Craig. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var meanTextField: NSTextField!
    @IBOutlet weak var sdTextField: NSTextField!
    @IBOutlet weak var numResultsTextField: NSTextField!
    var results = [Int:Double]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func generateDistribution(sender: AnyObject) {
        var res = PCGaussianData(mean: meanTextField.doubleValue, standardDeviation: sdTextField.doubleValue, numResultsRequired: numResultsTextField.integerValue)
        
        results = res.createDistribution()
    }


}

