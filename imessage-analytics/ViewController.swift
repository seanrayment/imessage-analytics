//
//  ViewController.swift
//  eqrqe
//
//  Created by Lucas Jurgensen on 5/25/17.
//  Copyright © 2017 Lucas Jurgensen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var entryField: NSTextField!
    
    func getEntryField() -> String{
        return entryField.stringValue
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func entryButton(_ sender: Any) {
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let resultController : ResultController = segue.destinationController as! ResultController
        resultController.labelText = entryField.stringValue
    }
}

