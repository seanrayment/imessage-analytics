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
    //var name = ViewController.getEntryField(<#T##ViewController#>)
    
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
    
    var my_num: Int = 0
    //A dictionary with the prevalence of words as the values for me
    
    var their_num: Int = 0
    //A dictionary with the prevalence of words as the values for them
    
    var my_pop = [["dog", 1],["cat", 0]]
    //A list of lists with my words and their occurance
    //       eg. [["dog", 35], ["cat", 1]]
    
    var their_pop = [["dog", 0],["cat", 1]]
    // A list of lists with their words and their occurance
    

//-----------------//
// Class Functions //
//-----------------//
    
    // Read in Conversation Text //
    func getPerson() -> String {
        return self.person
    }
    
//----------------------//
// Assigning Attributes //
//----------------------//
    
    
    //    func ImportSingleNameData(fileName: String) -> [String]? {
    //         guard let path = Bundle.main.path(forResource: fileName, ofType: "txt")
    //            print(path)
    //            else {
    //            return ["dog"]
    //        }
    //
    //        do {
    //            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
    //            return content.components(separatedBy: "\n")
    //        } catch {
    //            return ["cat"]
    //        }
    //    }
    
}
