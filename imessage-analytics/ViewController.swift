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
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var name = "string"
    @IBAction func entryButton(_ sender: Any) {
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        textField.stringValue = "name"
    }
}

