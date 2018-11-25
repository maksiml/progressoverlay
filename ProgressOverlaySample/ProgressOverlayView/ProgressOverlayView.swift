//
//  ProgressOverlayView.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 11/25/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

open class ProgressOverlayView: NSView {
    /// Stores overlay window frame if it is overrideng by setting `frame` explicitly.
    private var overridenFrame: NSRect?
    
    /**
     The background color used by this window.
     
     The default background is semi-transparent gray.
    */
    open var backgroundColor = NSColor(white: 0.5, alpha: 0.3)
    
    /**
     The progress indicator that will be presented in the overlay view.
     
     The default progress indicator is spinner.
    */
    open var progressIndicator = NSProgressIndicator(frame: NSRect(x: 0, y: 0, width: 30, height: 30))
    
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required public init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setup()
    }
    
    /**
     The view’s frame rectangle, which defines its position and size in its superview’s coordinate system.
     
     The frame will use it's parent's visible frame unless explicitly set in this property. Once this property
     is set the progress overlay will stop automatically fitting its' parent.
    */
    override open var frame: NSRect {
        get {
            if let overridenFrame = overridenFrame {
                return overridenFrame
            }
            
            return super.frame
        }
        
        set(value) {
            overridenFrame = value
            super.frame = value
        }
    }
    
    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        backgroundColor.setFill()
        dirtyRect.fill()
    }
    
    override open func viewWillMove(toSuperview newSuperview: NSView?) {
        
        // the `newSuperView` will be nil when this view is removed thus indicating if we are in the
        // process of showing or hiding the overlay.
        if let newSuperview = newSuperview {
            
            // let's take all visible area if nothing else was specified.
            super.frame = overridenFrame ?? newSuperview.visibleRect
            
            // make sure that we resize with the parent view.
            autoresizingMask = [.maxYMargin, .maxXMargin, .minXMargin, .minYMargin, .height, .width]
            
            // keep progress indicator centered.
            progressIndicator.frame.origin = CGPoint(x: frame.width / 2 - progressIndicator.frame.width / 2, y: frame.height / 2 - progressIndicator.frame.height / 2)
            
            // start animation
            progressIndicator.startAnimation(self)
        } else {
            
            // stop animation when the overlay is removed.
            progressIndicator.stopAnimation(self)
        }
    }
    
    /// Initializes progress indicator.
    private func setup() {
        progressIndicator.autoresizingMask = [.maxYMargin, .maxXMargin, .minXMargin, .minYMargin]
        progressIndicator.isIndeterminate = true
        progressIndicator.style = .spinning
        addSubview(progressIndicator)
    }
}
