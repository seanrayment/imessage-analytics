//
//  Conversation.swift
//  imessage-analytics
//
//  Created by Lucas Jurgensen on 6/1/17.
//  Copyright © 2017 Sean Rayment. All rights reserved.
//

import Foundation


class Conversation {
    
    var convo:Array = [["hey", "howdy"],["hows", "it going?"]]
    
    // Initialize //
    init(person: String) {
        // set convo to the message array for the person/phone number
    }
    
    // Funcitons //
    func LengthOfConversation() -> Int {
        var length: Int
        length = convo.count
        return length
    }
    
    func NumMyTexts() -> Int {
        var num: Int = 0
        for text in convo{
            if text[0] == "Me"{
             num += 1
            }
        }
        return num
    }
    
    
    
}
