//
//  UtilityClass.swift
//  VisualEffectView
//
//  Created by Ruby Kaushik on 12/28/16.
//  Copyright © 2016 Ruby Kaushik. All rights reserved.
//

import Cocoa
import AppKit

class UtilityClass: NSObject {
  
   static var visualEffectView : NSVisualEffectView?
   static let sharedInstance = UtilityClass()
  
  
  /* Returns static instance of visualEffectView for highlighting the custom menuItem view */
  class func visualEffectViewInstance(frame : NSRect) -> NSVisualEffectView {
    if visualEffectView == nil {
      visualEffectView = NSVisualEffectView(frame: frame)
      visualEffectView!.blendingMode = .behindWindow
      UtilityClass.updateVisualEffectViewProperty()
      visualEffectView!.material = .selection
      visualEffectView!.state = .active
    }
    return visualEffectView!
  }
  
  class func releaseVisualEffectView() {
    visualEffectView = nil
  }
  
  /* If visualEffectView is nil then creates the instance of  visualEffectView otherwise update its property
   */
  class func updateEmphasizedPropertyOfVisualEffectViewWhileChangingInterfaceStyle(frame : NSRect) {
    if self.visualEffectView == nil {
      self.visualEffectView = self.visualEffectViewInstance(frame: frame)
    }
    else {
      UtilityClass.updateVisualEffectViewProperty()
    }
  }
  
  private class func updateVisualEffectViewProperty() {
    if NSWorkspace.shared().accessibilityDisplayShouldReduceTransparency {
      visualEffectView!.isEmphasized = true
    }
    else {
      if #available(OSX 10.12, *) {
        if UtilityClass.sharedInstance.isSystemInDarkMode() && NSColor.currentControlTint == NSControlTint.graphiteControlTint {
          visualEffectView!.isEmphasized =   false
//          visualEffectView?.wantsLayer = true
//          visualEffectView?.layer?.backgroundColor = NSColor.white.cgColor
        }
        else {
          visualEffectView!.isEmphasized = true
        }
      }
    }
  }
  
  func isSystemInDarkMode() -> Bool {
    if let modeName = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") {
      if modeName == "Light" {
        return false
      }
      return true
    }
    return false
  }
}
