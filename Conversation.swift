//
//  Conversation.swift
//  imessage-analytics
//
//  Created by Lucas Jurgensen on 6/1/17.
//  Copyright © 2017 Sean Rayment. All rights reserved.
//

import Foundation
import SQLite


class Conversation {
    
    var convo : Table
    var convoArray : [Row]
    var myMessages : Table
    var theirMessages : Table
    var myMessagesArr : [Row]
    var theirMessagesArr : [Row]
    var yourNumber : String
    var theirNumber : String
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
    
    // convo is full table for the particular Conversation of particular instance of class
    //
    // convo to be passed in through number/person's name in the init for the Conversation Class
    // --------------------------------------------------------------------
    // | messageID   | text          | is_from_me         | date           |
    // --------------------------------------------------------------------
    // | 23          | "hi there"    | 1                  | 42349892       |
    // --------------------------------------------------------------------
    // | 63          | "whats up"    | 0                  | 42349899       |
    // --------------------------------------------------------------------

    
    /**
     Initializer for Conversation. Sets properties and the database
     tables and columns
     - parameters:
        - convo : the Table of relevant conversations
        - yourNumber : String, user phone number
        - theirNumber : String, other persons's number
        - db : Connection, a connection to the chat.db database
     */
    init(convo : Table, yourNumber : String, theirNumber : String, db : Connection) {
        // set convo to the message array for the person/phone number
        self.convo = convo
        self.db = db
        self.convoArray = Array(try! db.prepare(convo))
        self.yourNumber = yourNumber
        self.theirNumber = theirNumber
        
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
        
        // initializing individual tables and arrays
        self.myMessages = self.convo.filter(is_from_me == 1)
        self.theirMessages = self.convo.filter(is_from_me == 0)
        self.myMessagesArr = Array(try! db.prepare(myMessages))
        self.theirMessagesArr = Array(try! db.prepare(theirMessages))
    }
    
    
    //-----------//
    // Methods   //
    //-----------//
    
    
    /**
     gets the total number of texts for this Conversation
     - returns: Int, the total numer of texts
     */
    func lengthOfConversation() -> Int {
        return self.convoArray.count
    }
    
    /**
     gets the total number of texts sent by user in this Conversation
     - returns: Int, the total numer of texts sent by user
     */
    func numTextsSent() -> Int {
      return self.myMessagesArr.count
    }

    /**
     gets the total number of texts sent by others in this Conversation
     - returns: Int, the total numer of texts sent by others
     */
    func numTextsReceived() -> Int {
       return self.theirMessagesArr.count
    }
    
    var sentWords : Int?
    var receivedWords : Int?
    
    /**
     gets the total number of words sent by user in Coversation throughout all texts
     - returns: Int, the total number of words sent by user
     */
    func numWordsSent() -> Int {
        var count = 0
        for row in myMessagesArr {
            if (row[text] == nil) {
                count += 0
            } else {
                count += row[text]!.components(separatedBy: " ").count
            }
            
        }
        sentWords = count
        return count
    }
    
    /**
     gets the total number of words sent by others in Coversation throughout all texts
     - returns: Int, the total number of words sent by others
     */
    func numWordsReceived() -> Int {
        var count = 0
        for row in theirMessagesArr {
            if (row[text] == nil) {
                count += 0
            } else {
                count += row[text]!.components(separatedBy: " ").count
            }
            
        }
        
        receivedWords = count
        return count
    }
    
    /**
     gets the average number of words user sent per text message in Conversation
     - returns: Int, the average number of words per user text
     */
    func MyAverageWordsPerText() -> Double {
        if (self.sentWords == nil) {
            return Double(self.numWordsSent()) / Double(self.numTextsSent())
        } else {
            return Double(self.sentWords! / self.numTextsSent())
        }
    }
   

    /**
     gets the average number of words other sent per text message in Conversation
     - returns: Int, the average number of words per other's text
     */
    func TheirAverageWordsPerText() -> Double {
        if (self.sentWords == nil) {
            return Double(self.numWordsReceived()) / Double(self.numTextsReceived())
        } else {
            return Double(self.receivedWords! / self.numTextsReceived())
        }
    }
  
    
    /**
     gets the participation of user in the conversation as a percentage
     - returns: Int, percentage of user's words as a whole of Conversation's words
     */
    func MyParticipation() -> Double {
        
        let sWords = self.sentWords == nil ? self.numWordsSent() : self.sentWords!
        let rWords = self.receivedWords == nil ? self.numWordsReceived() : self.receivedWords!
        
        return 100 * Double(sWords) / (Double(rWords + sWords))

    }
   
  
    /**
     gets the participation of other in the conversation as a percentage
     - returns: Int, percentage of other's words as a whole of Conversation's words
     - note: This will not work with group chats
     */
    func TheirParticipation() -> Double {
        
        let sWords = self.sentWords == nil ? self.numWordsSent() : self.sentWords!
        let rWords = self.receivedWords == nil ? self.numWordsReceived() : self.receivedWords!
        
        return 100 * Double(rWords) / (Double(rWords + sWords))    }


}
