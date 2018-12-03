//
//  DisablableTextView.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

class DisablableTextView: NSTextView {
    
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
    
    /// Prevents keyboard scrolling when user interaction is disabled.
    override func keyUp(with event: NSEvent) {
        if enabled {
            super.keyUp(with: event)
        }
    }
    
    /// Prevents keyboard scrolling when user interaction is disabled.
    override func keyDown(with event: NSEvent) {
        if enabled {
            super.keyDown(with: event)
        }
    }
    
    /// Prevents keyboard scrolling when user interaction is disabled.
    override func interpretKeyEvents(_ eventArray: [NSEvent]) {
        if enabled {
            super.interpretKeyEvents(eventArray)
        }
    }
    
    /// Disables the control.
    private func disable() {
        enabled = false
        isSelectable = false
        isEditable = false
    }
    
    /// Enables the control.
    private func enable() {
        enabled = true
        isSelectable = true
        isEditable = true
    }
}