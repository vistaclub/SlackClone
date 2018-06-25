//
//  ChatViewController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-24.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa
import Parse

class ChatViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate {
    
    
    
    @IBOutlet weak var messageText: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descriptionText: NSTextField!
    
    var channel : PFObject?
    var chats : [PFObject] = []
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        tableView.dataSource = self
        tableView.delegate = self
        messageText.delegate = self
    }
    
    func clearChat() {
        channel = nil
        chats = []
        tableView.reloadData()
        titleLabel.stringValue = ""
        descriptionText.stringValue = ""
        timer?.invalidate()
    }
    
    override func viewWillAppear() {
        clearChat()
    }
    
    func updateWithChannel(channel: PFObject) {
        self.channel = channel
        getChats()
        if let title = channel["title"] as? String {
            titleLabel.stringValue = "#\(title)"
            messageText.placeholderString = "Message #\(title)"
        }
        if let descrion = channel["descrion"] as? String {
            descriptionText.stringValue = descrion
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time:Timer) in
            print("We are getting chats")
            self.getChats()
        }
    }
    
    func getChats() {
        if channel != nil {
            let query = PFQuery(className: "Chat")
            query.includeKey("user")
            query.whereKey("channel", equalTo: channel!)
            query.addAscendingOrder("createdAt")
            query.findObjectsInBackground { (chats:[PFObject]?, error:Error?) in
                if error == nil {
                    if chats != nil {
                        if chats?.count != self.chats.count {
                            self.chats = chats!
                            self.tableView.reloadData()
                            self.tableView.scrollRowToVisible(self.chats.count - 1)
                        }
                    }
                }
            }
        }
    }


    func numberOfRows(in tableView: NSTableView) -> Int {
        return chats.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.make(withIdentifier: "chatCell", owner: nil) as? ChatCell {
            let chat = chats[row]
            if let message = chat["message"] as? String {
                cell.messageLabel.stringValue = message
            }
            if let user = chat["user"] as? PFUser {
                if let name = user["name"] as? String {
                    cell.nameLabel.stringValue = name
                }
                if let imageFile = user["profilePic"] as? PFFile {
                    imageFile.getDataInBackground(block: { (data:Data?, error:Error?) in
                        if error == nil {
                            let image = NSImage(data: data!)
                            cell.profilePicImageView.image = image
                        }
                    })
                }
                if let date = chat.createdAt {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMM d h:mm a"
                    cell.timeLabel.stringValue = formatter.string(from: date)
                }
            }
            return cell
        }
        return nil
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100.0
    }

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(insertNewline(_:)) {
            sendClicked(self)
        }
        return false
    }

    @IBAction func sendClicked(_ sender: Any) {
        let chat = PFObject(className: "Chat")
        chat["message"] = messageText.stringValue
        chat["user"] = PFUser.current()
        chat["channel"] = channel
        chat.saveInBackground { (success:Bool, error:Error?) in
            if success {
                print("It worked")
                self.messageText.stringValue = ""
                self.getChats()
            } else {
                print("Could not send chat")
            }
        }
    }
}
