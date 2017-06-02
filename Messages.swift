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
 
 # TODO:
 * handle group chats in sent and received
 * make more efficient by saving values to memory and calling methods in init
 
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
    var text : Expression<String?>
    var date : Expression<Int64>
    var handle_id : Expression<Int64>
    
    // chat columns
    var chatID : Expression<Int64>
    var room_name : Expression<String?>
    var chat_identifier : Expression<String>
    var last_addressed_handle : Expression<String>
    
    // handle columns
    var handleID : Expression<Int64>
    var handleNumber : Expression<String>
    
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
                chatID = Expression<Int64>("ROWID")
                room_name = Expression<String?>("room_name")
                chat_identifier = Expression<String>("chat_identifier")
                text = Expression<String?>("text")
                handleID = Expression<Int64>("ROWID")
                handleNumber = Expression<String>("id")
                date = Expression<Int64>("date")
                last_addressed_handle = Expression<String>("last_addressed_handle")
                handle_id = Expression<Int64>("handle_id")
                
            } catch  {
                throw DatabaseError.couldNotLoad
            }
        } else {
            throw DatabaseError.notFound
        }
    }
    
    //----------------------------------------//
    // Conversation independent               //
    // calculations                           //
    //----------------------------------------//
    
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
                              .filter(is_from_me == 0)
        
        let recArray = Array(try db.prepare(recTable))
        
        print("TOTAL MESSAGES SENT: \(recArray.count)")
        return recArray.count
    }
    
    
    /**
     gets the number of group chats that you are a part of
     - returns: Int, the number of group chats you are in
     */
    func getGroupCount() throws -> Int {
        
        let convoTable = chat.filter(room_name != nil)
        let convoArray = Array(try db.prepare(convoTable))
        
        print("TOTAL GROUP CHATS: \(convoArray.count)")
        return convoArray.count
    }
    
    
    /**
    gets the total number of conversations you are in
    - returns: Int, the total number of conversations
     */
    func getConvoCount() throws -> Int {
        
        let convoTable = chat.filter(room_name == nil)
        let convoArray = Array(try db.prepare(convoTable))
        
        print("TOTAL 1-on-1 CHATS: \(convoArray.count)")
        return convoArray.count
    }
    
    
    /**
     gets the total number of words you have sent
     - returns: Int, the total number of words sent
     */
    func getWordsSent() throws -> Int {
        var wordCount = 0
        let messageTable = message.filter(text != nil).filter(is_from_me == 1)
        let messageArray = Array(try db.prepare(messageTable))
        
        for item in messageArray { 
            let wordArr = item[text]!.components(separatedBy: " ")
            wordCount += wordArr.count
        }
        
        print("TOTAL WORDS SENT: \(wordCount)")
        return wordCount
    }
    
    /**
     gets the total number of words you have received
     - returns: Int, the total number of words received
     */
    func getWordsReceived() throws -> Int {
        var wordCount = 0
        let messageTable = message.filter(text != nil).filter(is_from_me == 0)
        let messageArray = Array(try db.prepare(messageTable))
        
        for item in messageArray {
            let wordArr = item[text]!.components(separatedBy: " ")
            wordCount += wordArr.count
        }
        
        print("TOTAL WORDS SENT: \(wordCount)")
        return wordCount
    }
    
    /**
     gets the average word length of your texts
     - returns: Int, the average text length
     */
    func getAverageTextLength() throws -> Int {
        return try! Int(getWordsSent() / getTotalSent())
    }
    
    //----------------------------------------//
    // Conversation data to be                //
    // tabulated elswhere                     //
    //----------------------------------------//
    
    
    /**
    gets the array of valid numbers that you have had conversations with
     - returns: Array : Row, the array of rows of valid id and number columns
     */
    func getValidNumbers() throws -> Array<Row> {
        let table = handle.select(handleID, handleNumber)
        let handleArr = Array(try db.prepare(table))
        return handleArr
    }
    
    /**
     gets all of the messages associated with a particular number
     - parameters
        - number : String, the string representing the number
     - returns: Array : Row
     */
    func getMessagesFromNumber(number: String) throws -> Array<Row> {
        let table = handle.select(handleID, handleNumber).filter(handleNumber == number)
        let handleRow = try! db.pluck(table)
        let the_handle : Int64! = (handleRow![handleID])
        let messageTable = message.select(messageID, text, is_from_me, date)
                                  .filter(handle_id == the_handle)
        let messageArr = Array(try! db.prepare(messageTable))
        return messageArr
    }
    
    // This will be stored in a conversation object which will have properties of your
    // own number and the number you are communicating with!
    // Note: this is merely representational, the actual format of the array is an array
    //       of database row, each row containing these columns
    
    // --------------------------------------------------------------------
    // | messageID   | text          | is_from_me         | date           |
    // --------------------------------------------------------------------
    // | 23          | "hi there"    | 1                  | 42349892       |
    // --------------------------------------------------------------------
    // | 63          | "whats up"    | 0                  | 42349899       |
    // --------------------------------------------------------------------
    
    //  ALTERNATE METHOD TO LOAD IN DATABASE:
    
    /*
     let fileManager = FileManager.default
     
     let dummyURL = URL(fileURLWithPath: "/fake/path")
     
     var databaseURL = try fileManager.url(for: .libraryDirectory, in: .allDomainsMask, appropriateFor: dummyURL, create: false)
     
     databaseURL.appendPathComponent("Messages/chat.db")
     
     let altDB = try Connection(databaseURL.absoluteString)
    */
    
}
