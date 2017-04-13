//
//  CustomView.swift
//  VisualEffectView
//
//  Created by Ruby Kaushik on 10/11/16.
//  Copyright © 2016 Ruby Kaushik. All rights reserved.
//

import Cocoa
// custom view for mmenu item's view
class CustomView: NSView {
  @IBOutlet var view: NSView!
  @IBOutlet var lbl: NSTextField!
  @IBOutlet var startStopButton: CustomButton!
  private var buttonBlock: ((MenuItemModel) -> ())?
  
  //To track weather menu item should be highlighted or not.
  private var shouldHighLight : Bool = false {
    didSet {
      if oldValue != shouldHighLight {
        needsDisplay = true
      }
    }
  }
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    // If user has enabled 'Reduce Transparency' in System Preferences
    // Then this block should execute
    if NSWorkspace.shared().accessibilityDisplayShouldReduceTransparency {
      if shouldHighLight {
        NSColor.selectedMenuItemColor.set()
      }
      else {
        NSColor.clear.set()
      }
      NSBezierPath.fill(dirtyRect)
    }
  }
  
  // Adding Tracking area to track mouse movements on view.
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
    self.addSubview(self.view)
  }
  
  // If transparency not alllowed by system than retuens false otherwise true
  override var allowsVibrancy: Bool {
    if NSWorkspace.shared().accessibilityDisplayShouldReduceTransparency {
      return false
    }
    return true
  }
  
  // To Configure the view
  func configure(model: MenuItemModel, buttonBlock: ((MenuItemModel) -> ())?) {
    startStopButton.object = model
    self.buttonBlock = buttonBlock
    self.lbl.stringValue = model.title
  }
  
  // Will change the image, after clicking the button
  func changeImage() {
    if startStopButton.tag == 307 {
      startStopButton.image = NSImage(named: "stop")
      startStopButton.tag = 308
    }
    else {
      startStopButton.image = NSImage(named: "play")
      startStopButton.tag = 307
    }
  }
  
  // By default, every menu item has its superview as NSVisualEffectView
  override func mouseEntered(with event: NSEvent) {
    super.mouseEntered(with: event)
    let menuItemViewer = self.superview as! NSVisualEffectView
    // Check if transparency is allowed.
    if !NSWorkspace.shared().accessibilityDisplayShouldReduceTransparency {
      // Change the appearance and material for the selection of menu
      menuItemViewer.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
      menuItemViewer.material = .selection
      if #available(OSX 10.12, *) {
        if NSColor.currentControlTint == NSControlTint.blueControlTint {
          menuItemViewer.isEmphasized = true
        }
      }
    }
    // change the color of label.
    lbl.textColor = NSColor.white
    // It will call the draw(:)
    shouldHighLight = true
  }
  
  // While exiting from the view, It will make NSVisualEffectView as default.
  override func mouseExited(with event: NSEvent) {
    super.mouseExited(with: event)
    if let v = enclosingMenuItem?.view?.superview as? NSVisualEffectView {
      v.appearance = nil
      v.material = .menu
    }
    lbl.textColor = NSColor.labelColor
    shouldHighLight = false
  }
  
  // Clicking on button, call the block 'buttonBlock()'
  @IBAction func startStopClicked(button: CustomButton) {
    self.buttonBlock!(button.object as! MenuItemModel)
  }
}
