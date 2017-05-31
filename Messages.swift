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

/**
 
 Class for loading the chat.db SQLite database
 
 - Author: Sean Rayment
 
 */
class Messages {
    
    var db : Connection
    
    var message : Table
    var handle : Table
    var chat : Table
    var chat_handle_join : Table
    var chat_message_join : Table
    var messageID : Expression<Int64>
    
    /**
     Errors when accessing database
     TODO: move to a separate file
     */
    enum DatabaseError : Error {
        case notFound
        case couldNotLoad
    }
    
    // URL of chat.db file
    let url = URL(fileURLWithPath: NSString(string: "~/Library/Messages/chat.db").expandingTildeInPath)
    
    /**
     Initializer for Messages. Attempts to form a Connection to the chat.db SQLite file
     - throws:
        - notFound: If the FileManager cannot locate the chat.db file
        - couldNotLoad: If the Connection fails to load the file
     */
    init() throws {
        
        let fileManager = FileManager()
        
        if (fileManager.fileExists(atPath: url.path)) {
            do {
                db = try Connection(url.absoluteString)
                
                message = Table("message")
                handle = Table("handle")
                chat = Table("chat")
                chat_handle_join = Table("chat_handle_join")
                chat_message_join = Table("chat_message_join")
                
                messageID = Expression<Int64>("ROWID")
                
            } catch  {
                throw DatabaseError.couldNotLoad
            }
        } else {
            throw DatabaseError.notFound
        }
    }
    
    /**
     gets the total number of messages sent and received
     - returns: Int
     */
    func getTotal() throws -> Int {
        
        let max = try db.scalar(message.select(messageID.max))
        return Int(max!)
        
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
