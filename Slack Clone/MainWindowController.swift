//
//  MainWindowController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-23.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    var loginVC : LoginViewController?
    var createAccountVC : CreateAccountViewController?
    var splitViewController : SplitViewController?
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        loginVC = contentViewController as? LoginViewController
    }
    
    func moveToCreateAccount() {
        
        if createAccountVC == nil {
            createAccountVC = storyboard?.instantiateController(withIdentifier: "createAccountVC") as? CreateAccountViewController
        }
        window?.contentView = createAccountVC?.view
        
    }

    func moveToChat() {
        if splitViewController == nil {
            splitViewController = storyboard?.instantiateController(withIdentifier: "splitVC") as? SplitViewController
        }
        window?.contentView = splitViewController?.view
    }
    
    func moveToLogin() {
        window?.contentView = loginVC?.view
    }
    
}
