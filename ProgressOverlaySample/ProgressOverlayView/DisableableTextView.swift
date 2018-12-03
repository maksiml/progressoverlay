//
//  DisableableTextView.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

class DisableableTextView: NSTextView {

    /// Indicates if the control currenly is enabled.
    public var isEnabled = true
    
    /// Disables the control.
    func disable() {
        isEnabled = false
        isSelectable = false
        isEditable = false
    }
    
    /// Enables the control.
    func enable() {
        isEnabled = true
        isSelectable = true
        isEditable = true
    }
    
    /// Prevent reacting to incomming messages when disabled.
    override func hitTest(_ point: NSPoint) -> NSView? {
        if isEnabled {
            return super.hitTest(point)
        }
        
        return nil
    }
}
