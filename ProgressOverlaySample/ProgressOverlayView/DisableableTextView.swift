//
//  DisableableTextView.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

class DisableableTextView: NSTextView {
    
    /// Saves current control state.
    private var enabled = true

    /// Indicates if the control currenly is enabled.
    public var isEnabled: Bool {
        get {
            return enabled
        }
        
        set(value) {
            enabled = value
            if enabled {
                enable()
            } else {
                disable()
            }
        }
    }
    
    /// Prevent reacting to incomming messages when disabled.
    override func hitTest(_ point: NSPoint) -> NSView? {
        if isEnabled {
            return super.hitTest(point)
        }
        
        return nil
    }
    
    /// Disables the control.
    private func disable() {
        isEnabled = false
        isSelectable = false
        isEditable = false
    }
    
    /// Enables the control.
    private func enable() {
        isEnabled = true
        isSelectable = true
        isEditable = true
    }
}
