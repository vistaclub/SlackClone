//
//  LoginViewController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-23.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa
import Parse

class LoginViewController: NSViewController {
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var emailTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + .nanoseconds(50)) {
            if var frame = self.view.window?.frame {
                frame.size = CGSize(width: 480, height: 310)
                self.view.window?.setFrame(frame, display: true, animate:true)
            }
        }
    }
    
    
    @IBAction func createAccountClicked(_ sender: Any) {
        
        if let mainVC = view.window?.windowController as? MainWindowController {
            mainVC.moveToCreateAccount()
        }
        
    }
    
    override func viewDidAppear() {
        if var frame = view.window?.frame {
            frame.size = CGSize(width: 480, height: 310)
            view.window?.setFrame(frame, display: true, animate:true)
        }
    }
    @IBAction func loginButtonClicked(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: emailTextField.stringValue, password: passwordTextField.stringValue) { (user:PFUser?, error:Error?) in
            if error == nil {
                print("You logged in!")
                if let mainVC = self.view.window?.windowController as? MainWindowController {
                    mainVC.moveToChat()
                } else {
                    print("There's a problem, couldn't log in")
                }
            }
        }
    }
}
