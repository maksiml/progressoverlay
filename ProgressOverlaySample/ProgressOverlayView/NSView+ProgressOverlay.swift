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
    
    /// Show the progress overlay.
    public func showOverlay() {
        
        if let overlay = progressOverlay {
            self.addSubview(overlay)
        }
    }
    
    /// Removes the progress overlay.
    func hideOverlay() {
        
        if let overlay = NSView.overlays.object(forKey: self) {
            overlay.removeFromSuperview()
        }
    }
}
