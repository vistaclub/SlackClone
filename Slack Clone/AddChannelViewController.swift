//
//  AddChannelViewController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-24.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa
import Parse

class AddChannelViewController: NSViewController {

    
    
    
    @IBOutlet weak var descriptionTextField: NSTextField!
    @IBOutlet weak var titleTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addChannelClicked(_ sender: Any) {
        
        let channel = PFObject(className: "Channel")
        channel["title"] = titleTextField.stringValue
        channel["descrion"] = descriptionTextField.stringValue
        channel.saveInBackground { (success:Bool, error:Error?) in
            if success {
                print("Channel Created")
                self.view.window?.close()
            } else {
                print("Unable to save Channel")
            }
        }
    }
    
    
}
