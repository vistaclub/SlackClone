//
//  SplitViewController.swift
//  Slack Clone
//
//  Created by Jason Wong on 2018-06-24.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        if let channelsVC = splitViewItems[0].viewController as? ChannelsViewController {
            if let chatVC = splitViewItems[1].viewController as? ChatViewController {
                channelsVC.chatVC = chatVC
            }
        }
        if var frame = view.window?.frame {
            frame.size = CGSize(width: 1000, height: 600)
            view.window?.setFrame(frame, display: true, animate:true)
        }
    }
}
