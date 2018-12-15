//
//  ViewController.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 11/25/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa
import CocoaProgressOverlay

class ViewController: NSViewController {

    @IBOutlet weak var testView: NSView!
    
    @IBOutlet weak var showOverlayButton: NSButtonCell!
    
    @IBOutlet var disabledTextView: NSScrollView!
    
    var showOverlay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func showOverlay(_ sender: Any) {
        showOverlay = !showOverlay
        if showOverlay {
            testView.showOverlay()
            showOverlayButton.title = "Hide overlay"
        } else {
            testView.hideOverlay()
            showOverlayButton.title = "Show overlay"
        }
    }
    
}

