//
//  NSTextField+UserInteraction.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

extension NSTextField {
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
    fileprivate static var savedStates = NSMapTable<NSTextField, SavedState>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /**
     Disables user interaction.
     
     Disable editing and selecting, but do not disable the control
     as it will remove any content.
    */
    internal func disableUserInteraction() {
        let saveState = SavedState(isEnabled: isEnabled, isEditable: isEditable, isSelectable: isSelectable)
        NSTextField.savedStates.setObject(saveState, forKey: self)
        
        self.isEditable = false
        self.isSelectable = false
    }
    
    /**
     Enables user interaction.
     
     Will restore the control to the state it was before `disableUserInteraction` was called.
    */
    internal func enableUserInteraction() {
        if let savedState = NSTextField.savedStates.object(forKey: self) {
            self.isEditable = savedState.isEditable
            self.isSelectable = savedState.isSelectable
        }
    }
}
