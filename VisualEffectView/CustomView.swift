//
//  CustomView.swift
//  VisualEffectView
//
//  Created by Ruby Kaushik on 10/11/16.
//  Copyright © 2016 Ruby Kaushik. All rights reserved.
//

import Cocoa

class CustomView: NSView {
  @IBOutlet var view: NSView!
@IBOutlet var lbl: NSTextField!
  
  private var shouldHighLight = false
  let labelColor = NSColor.labelColor
  override func awakeFromNib() {

  }
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    highLightView(frame : dirtyRect)
  
    // Drawing code here.
  }
  
  override func viewDidMoveToSuperview() {
    super.viewDidMoveToSuperview()
    let trackingArea = NSTrackingArea(rect: bounds, options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.activeInActiveApp], owner: self, userInfo: nil)
    self.addTrackingArea(trackingArea)
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    Bundle.main.loadNibNamed("CustomView", owner: self, topLevelObjects: nil)
    let contentRect = NSRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    self.view.frame = contentRect
    self.addSubview(self.view)
  }
  
  
  func configure(_ str : String) {
    self.lbl.stringValue = str
  }
  
  override func mouseEntered(with event: NSEvent) {
    super.mouseEntered(with: event)
    shouldHighLight = true
    self.needsDisplay = true
  }
  
  override func mouseExited(with event: NSEvent) {
    super.mouseEntered(with: event)
    shouldHighLight = false
    self.needsDisplay = true
  }
  
  func highLightView(frame : NSRect) {
    if shouldHighLight {
      let menuItemViewer = self.superview as! NSVisualEffectView
      if !UtilityClass.sharedInstance.isSystemInDarkMode() {
        menuItemViewer.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
      }
      let v = UtilityClass.visualEffectViewInstance(frame: frame)
      let c = menuItemViewer.subviews.first as? CustomView
      menuItemViewer.addSubview(v, positioned: .below, relativeTo: c)
    }
    else  {
      let menuItemViewer = self.superview as! NSVisualEffectView
      menuItemViewer.appearance = nil
      if let v = menuItemViewer.subviews.first as? NSVisualEffectView {
        v.removeFromSuperview()
      }
    }
  }
    
}
