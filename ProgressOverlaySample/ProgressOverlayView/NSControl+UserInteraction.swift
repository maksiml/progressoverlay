//
//  NSControl+UserInteraction.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

extension NSControl {
    /// Contains state of the control before user interaction is disabled.
    fileprivate class SavedState {
        var isEnabled: Bool
        
        init(isEnabled: Bool) {
            self.isEnabled = isEnabled
        }
    }
    
    /// Saves control state before user interaction was disabled.
    fileprivate static var savedStates = NSMapTable<NSControl, SavedState>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /**
     Disables user ineraction.
     
     The current state of the control will be retained and restored when
     `enableControlUserInteraction` will be called.
    */
    internal func disableControlUserInteraction() {
        NSControl.savedStates.setObject(SavedState(isEnabled: isEnabled), forKey: self)
        isEnabled = false
    }
    
    /**
     Enalbes user interaction.
     
     The interaction will only be enabled on the controls that were not disabled
     before `disableControlUserInteraction` was called.
    */
    internal func enableControlUserInteraction() {
        if let savedState = NSControl.savedStates.object(forKey: self) {
            if savedState.isEnabled {
                isEnabled = true
            }
        }
    }
}
