//
//  Conversation.swift
//  imessage-analytics
//
//  Created by Lucas Jurgensen on 6/1/17.
//  Copyright © 2017 Sean Rayment. All rights reserved.
//

import Foundation


class Conversation {
    
    var convo:Array<Array<String>> = [["hey", "howdy","hey", "howdy","hey", "howdy"],["hows", "it going?","hey", "howdy","hey", "howdy"]]
    //
    // convo is full array for the particular Conversation of particular instance of class
    //
    // convo to be passed in through number/person's name in the init for the Conversation Class
    //
    // Example convo struction
    // --------------------------------------------------------------------
    // | Person Name | Group         | Date       | Time  | Message (Str) |
    // --------------------------------------------------------------------
    // | Sean        | One-On-One    | 02/27/1998 | 13:34 | "Hey buddy"   |
    // --------------------------------------------------------------------
    // | Me          | One-On-One    | 02/27/1998 | 14:34 | "Go away you" |
    // --------------------------------------------------------------------
    //
    
    //------------//
    // Initialize //
    //------------//
    init(person: String) {
        // set convo to the message array for the person/phone number
    }
    
    
    //-----------//
    // Funcitons //
    //-----------//
    
    func LengthOfConversation() -> Int {
        var length: Int
        length = self.convo.count
        return length
    }
    /**
     gets the total number of texts for this Conversation
     - returns: Int, the total numer of texts
     */
    
    func NumMyTexts() -> Int {
        var num: Int = 0
        for text in self.convo{
            if text[0] == "Me"{
             num += 1
            }
        }
        return num
    }
    /**
     gets the total number of texts sent by user in this Conversation
     - returns: Int, the total numer of texts sent by user
     */
    
    func NumTheirTexts() -> Int {
        var num: Int = 0
        for text in self.convo{
            if text[0] != "Me"{
                num += 1
            }
        }
        return num
    }
    /**
     gets the total number of texts sent by others in this Conversation
     - returns: Int, the total numer of texts sent by others
     */
    
    func MyTotalWords() -> Int {
        var sum: Int = 0
        for text in self.convo{
            if text[0] == "Me" {
                let wordArr = text[4].components(separatedBy: " ")
                sum += wordArr.count
            }
        }
        return sum
    }
    /**
     gets the total number of words sent by user in Coversation throughout all texts
     - returns: Int, the total number of words sent by user
     */
    
    func TheirTotalWords() -> Int {
        var sum: Int = 0
        for text in self.convo{
            if text[0] != "Me" {
                let wordArr = text[4].components(separatedBy: " ")
                sum += wordArr.count
            }
        }
        return sum
    }
    /**
     gets the total number of words sent by others in Coversation throughout all texts
     - returns: Int, the total number of words sent by others
     */
    
    func MyAverageWordsPerText() -> Double {
        return Double(self.MyTotalWords()) / Double(self.NumMyTexts())
    }
    /**
     gets the average number of words user sent per text message in Conversation
     - returns: Int, the average number of words per user text
     */
    
    func TheirAverageWordsPerText() -> Double {
        return Double(self.TheirTotalWords()) / Double(self.NumTheirTexts())
    }
    /**
     gets the average number of words other sent per text message in Conversation
     - returns: Int, the average number of words per other's text
     */
    
    func MyParticipation() -> Double {
        return 100 * Double(self.MyTotalWords()) / (Double(self.MyTotalWords()) + Double(self.TheirTotalWords()))
    }
    /**
     gets the participation of user in the conversation as a percentage
     - returns: Int, percentage of user's words as a whole of Conversation's words
     */
    
    func TheirParticipation() -> Double {
        return 100 * Double(self.TheirTotalWords()) / (Double(self.MyTotalWords()) + Double(self.TheirTotalWords()))
    }
    /**
     gets the participation of other in the conversation as a percentage
     - returns: Int, percentage of other's words as a whole of Conversation's words
     */
    
    func MyWordPopDictionary() -> [String: Int] {
    var dic = [String: Int]()
        for text in self.convo {
            if text[0] == "Me"{
                let textArr = text[4].components(separatedBy: " ")
                for word in textArr {
                    if (dict[word] != nul) {
                        dic[word] += 1
                    }
                    else{
                        dic[word] = 1
                    }
                }
            }
        }
    return dic
    }
        
        
        
        
        
        
    
    
}
