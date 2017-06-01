//
//  AppLogic.swift
//  imessage-analytics
//
//  Created by Lucas Jurgensen on 5/26/17.
//  Copyright © 2017 Sean Rayment. All rights reserved.
//

import Foundation


class Conversation {
// A class which will hold all of the details for a specific iMesage conversation with person (person)
    
//------------------//
// Class Attributes //
//------------------//
    var person: String = "Sean Rayment"
    // String of person's name in form <"first last"> eg. "Han Solo"
    
    var raw_text: String = "raw_rext"
    // File containing all of the raw text from database
    
    var file: String = ".txt"
    // The file name for the texing records
    
    var texts: [[String]] = [["hey"],["us"]]
    // A list of texts, for each text giving: name, time, words
    //      eg. ["Han Solo", "2017-03-22 04:32:26", "So where is Chewy?]
    
    var my_texts: [[String]] = [["hey"],["me"]]
    // A list of just the texts sent by me
    
    var their_texts: [[String]] = [["hey"],["you"]]
    // A list of just the texts sent by person
    
    var length: Int = 0
    // The number of text messages in the conversation
    
    var my_prev: Int = 0
    //A dictionary with the prevalence of words as the values for me
    
    var their_prev: Int = 0
    //A dictionary with the prevalence of words as the values for them
    
    var my_pop = [["dog", 1],["cat", 0]]
    //A list of lists with my words and their occurance
    //       eg. [["dog", 35], ["cat", 1]]
    
    var their_pop = [["dog", 0],["cat", 1]]
    // A list of lists with their words and their occurance
    
//--------------------//
// Class Initializing //
//--------------------//
    
    init(person: String) {
        self.person = person
        // look at sean's database
        // use self.person to extract only specific data for person
        // let tempfile = specific data
        // self.raw_text = tempfile
        
        // self.lower_raw_text = lowercase version of raw_text
        
        var temp_my_texts: [[String]] = []
        var temp_their_texts: [[String]] = []
        
        for text in self.lower_raw_text{
            if ("Me" == text[0]){
                my_texts.insert(text, at: 0)
            }
            else{
                their_texts.insert(text, at:0)
            }
        }
        
        self.my_texts = temp_my_texts
        self.their_texts = temp_their_texts
    }

//-----------------//
// Class Functions //
//-----------------//
    
    // Read in Conversation Text //
    func getPerson() -> String {
        return self.person
    }
    
    }

// Get relevant data funciton
// --------------------------------------------------------------------
// | Person Name | Group         | Date       | Time  | Message (Str) |
// --------------------------------------------------------------------
// | Sean        | One-On-One    | 02/27/1998 | 13:34 | "Hey buddy"   |
// --------------------------------------------------------------------
// | Lucas       | One-On-One    | 02/27/1998 | 14:34 | "Go away you" |
// --------------------------------------------------------------------

    
