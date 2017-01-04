//
//  StatusMenuController.swift
//  VisualEffectView
//
//  Created by Ruby Kaushik on 10/11/16.
//  Copyright © 2016 Ruby Kaushik. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, NSMenuDelegate {

  @IBOutlet weak var statusMenu: NSMenu!
   @IBOutlet weak var subMenu: NSMenu!
  @IBOutlet weak var subMenuItem : NSMenuItem!
  let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
  
  let frame = NSRect(x: 0, y: 0, width: 200, height: 40)
  
  override func awakeFromNib() {
  configureStatusItem()
   subMenuItem.submenu = self.subMenu
  configureSubMenu() 
  }
  
  func configureStatusItem() {
    statusItem.title = "Thrifty"
    statusItem.menu = statusMenu
    if let button = statusItem.button {
      button.image = NSImage(named: "alert")
    }
    
    let customView = CustomView(frame: frame)
     let projectMenuItem1 = NSMenuItem(title: "Project1", action: nil, keyEquivalent: "")
    customView.configure("view")
    projectMenuItem1.view = customView
    statusMenu.insertItem(projectMenuItem1, at: 0)
    
    
    let customView1 = CustomView(frame: frame)
    let projectMenuItem2 = NSMenuItem(title: "Project1", action: #selector(StatusMenuController.click(_:)), keyEquivalent: "")
    customView1.configure("view 1")
    projectMenuItem2.view = customView1
    statusMenu.insertItem(projectMenuItem2, at: 0)
  }
  
  
  @IBAction func click(_ sender: NSMenuItem) {
  }
  
  func configureSubMenu() {
    let customView = CustomView(frame: frame)
    let projectMenuItem1 = NSMenuItem(title: "Project1", action: nil, keyEquivalent: "")
    customView.configure("view")
    projectMenuItem1.view = customView
    subMenu.insertItem(projectMenuItem1, at: 0)
    
    
    let customView1 = CustomView(frame: frame)
    let projectMenuItem2 = NSMenuItem(title: "Project1", action: #selector(StatusMenuController.click(_:)), keyEquivalent: "")
    customView1.configure("view 1")
    projectMenuItem2.view = customView1
    subMenu.insertItem(projectMenuItem2, at: 0)
  }
  
  func menuNeedsUpdate(_ menu: NSMenu) {
    UtilityClass.updateVisualEffectView(frame: frame)
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
