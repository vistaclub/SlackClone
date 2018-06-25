//
//  ChatCell.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-24.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa

class ChatCell: NSTableCellView {

    
    @IBOutlet weak var profilePicImageView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var messageLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
