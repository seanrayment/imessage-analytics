//
//  ResultController.swift
//  imessage-analytics
//
//  Created by Sean Rayment on 5/26/17.
//  Copyright © 2017 Sean Rayment. All rights reserved.
//

import Cocoa

class ResultController : NSViewController {
    
    @IBOutlet weak var resultLabel: NSTextField!
    
    var labelText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.stringValue = labelText
    }
    
    
    
    
}
