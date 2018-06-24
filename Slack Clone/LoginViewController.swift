//
//  LoginViewController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-23.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func createAccountClicked(_ sender: Any) {
        
        if let mainVC = view.window?.windowController as? MainWindowController {
            mainVC.moveToCreateAccount()
        }
        
    }
}

