//
//  CreateAccountViewController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-23.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa
import Parse

class CreateAccountViewController: NSViewController {
    
    var profilePicFile : PFFile?
    
    @IBOutlet weak var profileImagePicView: NSImageView!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var nameTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if let mainVC = view.window?.windowController as? MainWindowController {
            mainVC.moveToLogin()
        }
        
    }
    
    @IBAction func chooseImageClicked(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = true
        openPanel.canChooseFiles = true
        openPanel.begin { (result) in
            if result == NSModalResponseOK {
                if let imageURL = openPanel.urls.first {
                    if let image = NSImage(contentsOf: imageURL) {
                        self.profileImagePicView.image = image
                        let imageData = self.jpegDataFrom(image: image)
                        self.profilePicFile = PFFile(data: imageData)
                        self.profilePicFile?.saveInBackground()
                    }
                }
            }
        }
    }
    
    func jpegDataFrom(image:NSImage) -> Data {
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageFileType.JPEG, properties: [:])!
        return jpegData
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        let user = PFUser()
        user.email = emailTextField.stringValue
        user.password = passwordTextField.stringValue
        user.username = emailTextField.stringValue
        user["name"] = nameTextField.stringValue
        user["profilePic"] = profilePicFile
        
        user.signUpInBackground { (success:Bool, error:Error?) in
            if success {
                print("Made a User!")
                if let mainVC = self.view.window?.windowController as? MainWindowController {
                    mainVC.moveToChat()
                } else {
                    print("We have a problem!")
                }
            }
        }
    }
}
