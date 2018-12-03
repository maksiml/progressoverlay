//
//  NSTextView+UserInteraction.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

extension NSTextView {
    /// Contains state of the control before user interaction is disabled.
    fileprivate class SavedState {
        var isEnabled: Bool
        
        var isEditable: Bool
        
        var isSelectable: Bool
        
        init(isEnabled: Bool, isEditable: Bool, isSelectable: Bool) {
            self.isEnabled = isEnabled
            self.isEditable = isEditable
            self.isSelectable = isSelectable
        }
    }
    
    /// Saves control state before user interaction was disabled.
    fileprivate static var savedStates = NSMapTable<NSTextView, SavedState>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /**
     Disables user interaction.
     
     Unless the control is derived from `DisableableTextView` only partial ineraction
     will be disabled. The user will not be able to edit the text, but insert cursor will still
     be shown when hovering over the control.
     
     The method will retain current control state and will restore when `enableUserInteraction`
     will be called.
    */
    internal func disableUserInteraction() {
        let savedState = SavedState(isEnabled: (self as? DisableableTextView)?.isEnabled ?? true, isEditable: isEditable, isSelectable: isSelectable)
        NSTextView.savedStates.setObject(savedState, forKey: self)
        
        if let diableableTextView = self as? DisableableTextView {
            diableableTextView.isEnabled = false
        }
        
        isSelectable = false
        isEditable = false
    }
    
    /**
     Enables user ineraction.
     
     Will restore the control to the state it was before `disableUserInteraction` was called.
    */
    internal func enableUserInteraction() {
        if let savedState = NSTextView.savedStates.object(forKey: self) {
            if let diableableTextView = self as? DisableableTextView {
                diableableTextView.isEnabled = savedState.isEnabled
            }
            
            isSelectable = savedState.isSelectable
            isEditable = savedState.isEditable
        }
    }
}
