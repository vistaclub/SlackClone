//
//  MainWindowController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-23.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    func moveToCreateAccount() {
        if let createAccountVC = storyboard?.instantiateController(withIdentifier: "createAccountVC") as? CreateAccountViewController {
            window?.contentView = createAccountVC.view
        }
    }
}
