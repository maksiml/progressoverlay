//
//  NSTextField+Selection.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

/// Extends 'NSTextField' to allow saving and restoring selection in the control.
extension NSTextField {
    /// Saves selected range.
    fileprivate class Selection {
        var range: NSRange?
        
        init(range: NSRange?) {
            self.range = range
        }
    }
    
    /// Saves selections for `NsTextField`.
    fileprivate static var preservedSelections = NSMapTable<NSTextField, NSObject>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /// Saves current selection.
    internal func preserveSelection() {
        let selectedRage = currentEditor()?.selectedRange
        NSTextField.preservedSelections.setObject(selectedRage as NSObject?, forKey: self)
    }
    
    /// Restores selection that was saved previously with `preserveSelection`.
    internal func restoreSelection() {
        if let selectedRage = NSTextField.preservedSelections.object(forKey: self) as? NSRange {
            currentEditor()?.selectedRange = selectedRage
        }
    }
}
