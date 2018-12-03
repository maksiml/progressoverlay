//
//  NSView+ProgressOverlay.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 11/25/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

extension NSView {
    
    /// Contains all overlays ever presented mapped to respective view.
    private static var overlays = NSMapTable<NSView, ProgressOverlayView>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
    private static var eventMonitors = NSMapTable<NSView, NSObject>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    
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
    
    /// Show the progress overlay.
    public func showOverlay() {
        if let overlay = progressOverlay {
            self.addSubview(overlay)
            var firstResponder = window?.firstResponder;
            var view = firstResponder as? NSView
            while view != nil {
                if let textField = view as? NSTextField {
                    textField.preserveSelection()
                    firstResponder = textField
                    break
                }
                view = view?.superview
            }
            
            NSView.firstResponders.setObject(firstResponder, forKey: self)
            self.window?.makeFirstResponder(overlay)
            
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
