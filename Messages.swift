//
//  Messages.swift
//  imessage-analytics
//
//  Created by Sean Rayment on 5/30/17.
//  Copyright © 2017 Sean Rayment. All rights reserved.
//

import Foundation
import Cocoa
import SQLite

class Messages {
    
    var db : Connection?
    var foundDatabase : Bool
    
    
    // URL of chat.db file
    let url = URL(fileURLWithPath: NSString(string: "~/Library/Messages/chat.db").expandingTildeInPath)
    
    // initializes the database connection - not guaranteed
    init() {
        
        let fileManager = FileManager()
        
        if (fileManager.fileExists(atPath: url.path)) {
            do {
                db = try Connection(url.absoluteString)
                foundDatabase = true
            } catch  {
                db = nil
                foundDatabase = false
            }
        } else {
            db = nil
            foundDatabase = false
        }
    }
    
    
    //  ALTERNATE METHOD TO LOAD IN DATABASE:
    
    /*
     let fileManager = FileManager.default
     
     let dummyURL = URL(fileURLWithPath: "/fake/path")
     
     var databaseURL = try fileManager.url(for: .libraryDirectory, in: .allDomainsMask, appropriateFor: dummyURL, create: false)
     
     databaseURL.appendPathComponent("Messages/chat.db")
     
     let altDB = try Connection(databaseURL.absoluteString)
    */
    
}
