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
    @IBOutlet weak var inputName: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    var name = "string"
    @IBAction func entryButton(_ sender: Any) {
        var name = entryField.stringValue
        inputName.stringValue = "hey"
    }
    
}

