//
//  DisableableTextView.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

class DisableableTextView: NSTextView {

    /// Indicates if the control currenly is disabled.
    private var disabled = false
    
    /// Disables the control.
    func disable() {
        disabled = true
        isSelectable = false
        isEditable = false
    }
    
    /// Enables the control.
    func enable() {
        disabled = false
        isSelectable = true
        isEditable = true
    }
    
    /// Prevent reacting to incomming messages when disabled.
    override func hitTest(_ point: NSPoint) -> NSView? {
        if disabled {
            return nil
        }
        
        return super.hitTest(point)
    }
}
