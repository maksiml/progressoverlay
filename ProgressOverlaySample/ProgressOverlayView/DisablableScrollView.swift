//
//  DisablableScrollView.swift
//  ProgressOverlaySample
//
//  Created by Maksim Libenson on 12/3/18.
//  Copyright © 2018 Maksim Libenson. All rights reserved.
//

import Cocoa

class DisablableScrollView: NSScrollView {
    /// Indicates if scrolling is enabled.
    public var isScrollable = true
    
    /// Prevents mouse scrolling when user interaction is disabled.
    override func scrollWheel(with event: NSEvent) {
        if isScrollable {
            super.scrollWheel(with: event)
        }
    }
}
