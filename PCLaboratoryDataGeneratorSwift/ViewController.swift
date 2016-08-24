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
    @IBOutlet weak var resultsTableView: NSTableView!
    
    var results = [Int:Double]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.setDelegate(self)
        resultsTableView.setDataSource(self)
        
        
    
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
        resultsTableView.reloadData()
    }


}

extension ViewController : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return results.count ?? 0
    }
}

extension ViewController : NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var res:Double?
        var cellIdentifier: String = ""
        
        // 1
        guard results[row] != nil else {
            return nil
        }
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            res = results[row]
            cellIdentifier = "ResultsCell"
        }
        
        // 3
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = String(format:"%f", res!)
            return cell
        }
        return nil
    }
}