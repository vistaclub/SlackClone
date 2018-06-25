//
//  ChannelsViewController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-24.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa
import Parse

class ChannelsViewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource {
    
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var profilePicImageView: NSImageView!
    @IBOutlet weak var tableView: NSTableView!
    
    var channels : [PFObject] = []
    var chatVC : ChatViewController?
    var addChannelWC : NSWindowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidAppear() {
        getChannels()
        if let user = PFUser.current() {
            if let name = user["name"] as? String {
                nameLabel.stringValue = name
            }
            if let imageFile = user["profilePic"] as? PFFile {
                imageFile.getDataInBackground(block: { (data:Data?, error:Error?) in
                    if error == nil {
                        let image = NSImage(data: data!)
                        self.profilePicImageView.image = image
                    }
                })
            }
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        chatVC?.clearChat()
        PFUser.logOut()
        if let mainVC = view.window?.windowController as? MainWindowController {
            mainVC.moveToLogin()
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let addChannelWC = storyboard?.instantiateController(withIdentifier: "addChannelWC") as? NSWindowController
        addChannelWC?.showWindow(nil)
    }
    
    func getChannels() {
        let query = PFQuery(className: "Channel")
        query.order(byAscending: "title")
        query.findObjectsInBackground { (channels:[PFObject]?, error:Error?) in
            if channels != nil {
                self.channels = channels!
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let channel = channels[row]
        
        if let cell = tableView.make(withIdentifier: "channelCell", owner: nil) as? NSTableCellView {
            
            if let title = channel["title"] as? String {
                cell.textField?.stringValue = "#\(title)"
                return cell
            }
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow < 0 {
            
        } else {
            let channel = channels[tableView.selectedRow]
            chatVC?.updateWithChannel(channel: channel)
        }
    }
}
