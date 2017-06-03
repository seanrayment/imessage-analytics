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
    var rowArr : [Row]
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

    
    //------------//
    // Initialize //
    //------------//
    init(convo : Table, yourNumber : String, theirNumber : String, db : Connection) {
        // set convo to the message array for the person/phone number
        self.convo = convo
        self.db = db
        self.rowArr = Array(try! db.prepare(convo))
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
    }
    
    
    //-----------//
    // Funcitons //
    //-----------//
    
    func lengthOfConversation() -> Int {
        return self.rowArr.count
    }
    
    /**
     gets the total number of texts for this Conversation
     - returns: Int, the total numer of texts
     */
    
    func NumMyTexts() -> Int {
        let meConvo = self.convo.filter(is_from_me == 1)
        let meArray = Array(try! db.prepare(meConvo))
        return meArray.count
    }
    /**
     gets the total number of texts sent by user in this Conversation
     - returns: Int, the total numer of texts sent by user
     */
//    
//    func NumTheirTexts() -> Int {
//        let themConvo = self.convo.filter(is_from_me == 0)
//        let themArray = Array(try! db.prepare(meConvo))
//        return themArray.count
//    }
//    /**
//     gets the total number of texts sent by others in this Conversation
//     - returns: Int, the total numer of texts sent by others
//     */
//    
//    func MyTotalWords() -> Int {
//        var sum: Int = 0
//        for text in self.convo{
//            if text[0] == "Me" {
//                let wordArr = text[4].components(separatedBy: " ")
//                sum += wordArr.count
//            }
//        }
//        return sum
//    }
//    /**
//     gets the total number of words sent by user in Coversation throughout all texts
//     - returns: Int, the total number of words sent by user
//     */
//    
//    func TheirTotalWords() -> Int {
//        var sum: Int = 0
//        for text in self.convo{
//            if text[0] != "Me" {
//                let wordArr = text[4].components(separatedBy: " ")
//                sum += wordArr.count
//            }
//        }
//        return sum
//    }
//    /**
//     gets the total number of words sent by others in Coversation throughout all texts
//     - returns: Int, the total number of words sent by others
//     */
//    
//    func MyAverageWordsPerText() -> Double {
//        return Double(self.MyTotalWords()) / Double(self.NumMyTexts())
//    }
//    /**
//     gets the average number of words user sent per text message in Conversation
//     - returns: Int, the average number of words per user text
//     */
//    
//    func TheirAverageWordsPerText() -> Double {
//        return Double(self.TheirTotalWords()) / Double(self.NumTheirTexts())
//    }
//    /**
//     gets the average number of words other sent per text message in Conversation
//     - returns: Int, the average number of words per other's text
//     */
//    
//    func MyParticipation() -> Double {
//        return 100 * Double(self.MyTotalWords()) / (Double(self.MyTotalWords()) + Double(self.TheirTotalWords()))
//    }
//    /**
//     gets the participation of user in the conversation as a percentage
//     - returns: Int, percentage of user's words as a whole of Conversation's words
//     */
//    
//    func TheirParticipation() -> Double {
//        return 100 * Double(self.TheirTotalWords()) / (Double(self.MyTotalWords()) + Double(self.TheirTotalWords()))
//    }
//    /**
//     gets the participation of other in the conversation as a percentage
//     - returns: Int, percentage of other's words as a whole of Conversation's words
//     */
//    
//    
//    /*
// 
//    func MyWordPopDictionary() -> [String: Int] {
//    var dic = [String: Int]()
//        for text in self.convo {
//            if text[0] == "Me"{
//                let textArr = text[4].components(separatedBy: " ")
//                for word in textArr {
//                    if (dict[word] != nul) {
//                        dic[word] += 1
//                    }
//                    else{
//                        dic[word] = 1
//                    }
//                }
//            }
//        }
//    return dic
//    }
//    
//    */
//        
//        
//        
//        
//    }
//    
//}

}
