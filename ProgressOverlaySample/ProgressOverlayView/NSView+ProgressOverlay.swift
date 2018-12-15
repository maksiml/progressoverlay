//
//  NSView+ProgressOverlay.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 11/25/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

/// Extends 'NSView' to show a progress overlay.
extension NSView {
    
    /// Contains all overlays ever presented mapped to respective views.
    private static var overlays = NSMapTable<NSView, ProgressOverlayView>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /// Contains event monitors associated with different views when overlay is called.
    private static var eventMonitors = NSMapTable<NSView, NSObject>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /// Constains first responders recorded before overlay was presented.
    private static var firstResponders = NSMapTable<NSView, NSResponder>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    /// Retrieves a progress overlay associate with the current view. Creates a new one
    /// if the view was not yet created.
    public var progressOverlay: ProgressOverlayView? {
        get {
            if NSView.overlays.object(forKey: self) == nil {
                NSView.overlays.setObject(ProgressOverlayView(), forKey: self)
            }
            
            guard let overlay = NSView.overlays.object(forKey: self) else {
                return nil
            }
            
            return overlay
        }
    }
    
    /// Retrieves all sub-views recursively.
    private var allSubviews: [NSView] {
        get {
            var result = [NSView]()
            var stack = [NSView]()
            stack.append(contentsOf: subviews)
            
            while stack.count > 0 {
                let current = stack.removeLast()
                result.append(current)
                stack.append(contentsOf: current.subviews)
            }
            
            return result
        }
    }
    
    /// Shows the progress overlay.
    public func showOverlay() {
        if let overlay = progressOverlay {
            self.addSubview(overlay)
            var firstResponder = window?.firstResponder;
            var view = firstResponder as? NSView
            
            // Special handling for NSTextField as first responder in that
            // case is internal NSTextView, we cannot set it as the first responder
            // directly.
            while view != nil {
                if let textField = view as? NSTextField {
                    // We must preserve the selection, else when setting the NSTextField
                    // back as first responder all the text in the control will be selected
                    // and current selection will be lost.
                    textField.preserveSelection()
                    firstResponder = textField
                    break
                }
                view = view?.superview
            }
            
            NSView.firstResponders.setObject(firstResponder, forKey: self)
            
            // Move focus to overlay.
            self.window?.makeFirstResponder(overlay)
            
            // Stop passing mouse and keyboard events to the underlying controls.
            let monitor = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseUp, .rightMouseUp, .leftMouseDown, .rightMouseUp, .scrollWheel, .mouseEntered, .mouseExited, .cursorUpdate, .otherMouseUp, .otherMouseDown, .leftMouseDragged, .rightMouseDragged, .otherMouseDragged]) { event in
                if self.hitTest(event.locationInWindow) != nil {
                    return nil
                }
                
                return event
            }
            
            NSView.eventMonitors.setObject(monitor as? NSObject, forKey: self)
        }
    }
    
    /// Removes the progress overlay.
    func hideOverlay() {
        if let firstResponder = NSView.firstResponders.object(forKey: self) {
            window?.makeFirstResponder(firstResponder)
            
            // Restore saved selection if the first responder was a NSTextField
            if let textField = firstResponder as? NSTextField {
                textField.restoreSelection()
            }
        }
        
        if let overlay = NSView.overlays.object(forKey: self) {
            overlay.removeFromSuperview()
        }
        
        if let monitor = NSView.eventMonitors.object(forKey: self) {
            NSEvent.removeMonitor(monitor)
            NSView.eventMonitors.removeObject(forKey: self)
        }
    }
}
