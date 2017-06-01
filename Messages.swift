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
import Contacts

/**
 
 Class for loading the chat.db SQLite database
 
 - Author: Sean Rayment
 
 */
class Messages {
    
    var db : Connection
    
    // chat.db tables
    var message : Table
    var handle : Table
    var chat : Table
    var chat_handle_join : Table
    var chat_message_join : Table
    
    // message columns
    var messageID : Expression<Int64>
    var is_from_me : Expression<Int64>
    
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
                
                // initializing tables
                message = Table("message")
                handle = Table("handle")
                chat = Table("chat")
                chat_handle_join = Table("chat_handle_join")
                chat_message_join = Table("chat_message_join")
                
                // initializing columns
                messageID = Expression<Int64>("ROWID")
                is_from_me = Expression<Int64>("is_from_me")
                
            } catch  {
                throw DatabaseError.couldNotLoad
            }
        } else {
            throw DatabaseError.notFound
        }
    }
    
    //--------------------------//
    // Conversation independent //
    // calculations             //
    //--------------------------//
    
    /**
     gets the total number of messages sent and received
     - returns: Int, the number of messages sent or received
     */
    func getTotal() throws -> Int {
        
        let max = try db.scalar(message.select(messageID.max))
        print("TOTAL MESSAGES: \(max)")
        return Int(max!)
    }
    
    /**
    gets the total number of messages sent
     - returns: Int, the number of messages sent
     ## Note:
     This calculation includes group chats, which throws off the balance
     between messages sent vs. received.
    */
    func getTotalSent() throws -> Int {
        
        let sentTable = message.select(messageID)
                               .filter(is_from_me == 1);
        
        let sentArray = Array(try db.prepare(sentTable))
        
        print("TOTAL MESSAGES SENT: \(sentArray.count)")
        return sentArray.count
    }
    
    
    /**
     gets the total number of messages received
     - returns: Int, the number of messages received
     ## Note:
     This calculation includes group chats, which throws off the balance
     between messages sent vs. received.
     */
    func getTotalReceived() throws -> Int {
        
        let recTable = message.select(messageID)
            .filter(is_from_me == 0);
        
        let recArray = Array(try db.prepare(recTable))
        
        print("TOTAL MESSAGES SENT: \(recArray.count)")
        return recArray.count
    }
    
    
    /**
     gets the number of group chats that you are a part of
     - returns: Int, the number of group chats you are in
     */
    
    
    /**
    gets the total number of conversations you are in
    - returns: Int, the total number of conversations
     */
    
    
    /**
     gets the total number of words you have sent
     - returns: Int, the total number of words sent
     */
    
    /**
     gets the total number of words you have received
     - returns: Int, the total number of words received
     */
    
    /**
     gets the average word length of your texts
     - returns: Int, the average text length
     */
    
    
    
    
    //  ALTERNATE METHOD TO LOAD IN DATABASE:
    
    /*
     let fileManager = FileManager.default
     
     let dummyURL = URL(fileURLWithPath: "/fake/path")
     
     var databaseURL = try fileManager.url(for: .libraryDirectory, in: .allDomainsMask, appropriateFor: dummyURL, create: false)
     
     databaseURL.appendPathComponent("Messages/chat.db")
     
     let altDB = try Connection(databaseURL.absoluteString)
    */
    
}
