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
        }
        
        disableControls()
    }
    
    /// Removes the progress overlay.
    func hideOverlay() {
        if let overlay = NSView.overlays.object(forKey: self) {
            overlay.removeFromSuperview()
        }
        
        enableControls()
    }
    
    /// Disables controls in the view while overllay is present.
    private func disableControls() {
        for subView in allSubviews {
            if let disableableTextView = subView as? DisableableTextView {
                disableableTextView.disable()
            } else if let control = subView as? NSControl {
                control.isEnabled = false
            }
        }
    }
    
    /// Enables controls in the view when overlay is removed.
    private func enableControls() {
        for subView in allSubviews {
            if let disableableTextView = subView as? DisableableTextView {
                disableableTextView.enable()
            } else if let control = subView as? NSControl {
                control.isEnabled = true
            }
        }
    }
}
