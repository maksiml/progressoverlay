//
//  NSScrollView+UserIneraction.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

extension NSScrollView {
    /// Contains state of the control before user interaction is disabled.
    fileprivate class SavedState {
        var isScrollable: Bool
        
        var hasHorizontalScroller: Bool
        
        var hasVerticalScroller: Bool
        
        init(isScrollable: Bool, hasHorizontalScroller: Bool, hasVerticalScroller: Bool) {
            self.isScrollable = isScrollable
            self.hasHorizontalScroller = hasHorizontalScroller
            self.hasVerticalScroller = hasVerticalScroller
        }
    }
    
    /// Saves control state before user interaction was disabled.
    fileprivate static var savedStates = NSMapTable<NSScrollView, SavedState>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /**
     Disables scrolling.
     
     The scrolling will be properly disabled only when the view is inheriting
     `DisableableScrollView` scroll view.
    */
    internal func disableUserInteraction() {
        var isScrollable = false
        if let disablableScrollView = self as? DisablableScrollView {
            isScrollable = disablableScrollView.isScrollable
            disablableScrollView.isScrollable = false
        }
        let savedState = SavedState(isScrollable: isScrollable, hasHorizontalScroller: hasHorizontalScroller, hasVerticalScroller: hasVerticalScroller)
        
        NSScrollView.savedStates.setObject(savedState, forKey: self)
        
        hasHorizontalScroller = false
        hasVerticalScroller = false
    }
    
    /**
     Restores previous scrolling state.
    */
    internal func enableUserInteraction() {
        if let savedState = NSScrollView.savedStates.object(forKey: self) {
            if let disableableScrollView = self as? DisablableScrollView {
                disableableScrollView.isScrollable = savedState.isScrollable
            }
            
            hasHorizontalScroller = savedState.hasHorizontalScroller
            hasVerticalScroller = savedState.hasVerticalScroller
        }
    }
}
