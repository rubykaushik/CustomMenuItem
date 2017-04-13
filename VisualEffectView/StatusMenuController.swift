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
  
  private var menuItemArray: [MenuItemModel] = []
  private var subMenuItemArray: [MenuItemModel] = []
  
  override func awakeFromNib() {
    getDataArray()
    configureStatusItem()
    subMenuItem.submenu = self.subMenu
    configureSubMenu()
  }
  
  func getDataArray() {
    let menuItem1 = MenuItemModel(title: "View 1")
    let menuItem2 = MenuItemModel(title: "View 2")
    let menuItem3 = MenuItemModel(title: "View 3")
    let menuItem4 = MenuItemModel(title: "View 4")
    menuItemArray = [menuItem1, menuItem2, menuItem3, menuItem4]
    
    let submenuItem1 = MenuItemModel(title: "Sub View 1")
    let submenuItem2 = MenuItemModel(title: "Sub View 2")
    let submenuItem3 = MenuItemModel(title: "Sub View 3")
    subMenuItemArray = [submenuItem1, submenuItem2, submenuItem3]
  }
  
  func configureStatusItem() {
    statusItem.title = "Thrifty"
    statusItem.menu = statusMenu
    if let button = statusItem.button {
      button.image = NSImage(named: "alert")
    }
    
    for i in 0..<menuItemArray.count {
      let menuItemModel = menuItemArray[i]
      let customView = CustomView(frame: frame)
      let projectMenuItem1 = NSMenuItem(title: menuItemModel.title, action: #selector(StatusMenuController.click(_:)), keyEquivalent: "")
      customView.configure(model: menuItemModel, buttonBlock: { (model) in
        
      })
      projectMenuItem1.target = self
      projectMenuItem1.view = customView
      statusMenu.insertItem(projectMenuItem1, at: i)
    }
  }
  
  
  @IBAction func click(_ sender: NSMenuItem) {
  }
  
  @IBAction func quit(_ sender: NSMenuItem) {
    NSApplication.shared().terminate(self)
  }
  
  // To make sub menu
  func configureSubMenu() {
    for i in 0..<subMenuItemArray.count {
      let menuItemModel = subMenuItemArray[i]
      let customView = CustomView(frame: frame)
      let projectMenuItem1 = NSMenuItem(title: menuItemModel.title, action: #selector(StatusMenuController.click(_:)), keyEquivalent: "")
      projectMenuItem1.target = self
      customView.configure(model: menuItemModel, buttonBlock: { (model) in
        
        let item = self.subMenu.item(withTitle: model.title)
        let view = item!.view as! CustomView
        view.changeImage()
        
      })
      projectMenuItem1.view = customView
      subMenu.insertItem(projectMenuItem1, at: i)
      
    }
  }
  
  override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
    return true
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
