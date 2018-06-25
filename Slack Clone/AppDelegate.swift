//
//  AppDelegate.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-23.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa
import Parse

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let config = ParseClientConfiguration {
            (configThing: ParseMutableClientConfiguration) in
            configThing.applicationId = "slackclone"
            configThing.server = "http://localhost:1337/parse"
        }
        Parse.initialize(with: config)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

