//
//  AppDelegate.swift
//  imessage-analytics
//
//  Created by Sean Rayment on 5/25/17.
//  Copyright © 2017 Sean Rayment. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


// Database Format
//
// Example:
//
// +17816408434~02/27/1998~15:38~These are not the droids you're looking for
// ["+17816408434", "02/27/1998", "15:38", "These are not the droids you're looking for"]
// ["+15085056853", "05/04/1998", "13:10", "It's my birthday today"]
// ["+17816408434", "02/27/1998", "15:38", "You're a dingus"]
// 


