//
//  SKNodeExtension.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 15-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit



protocol RoomSceneDelegate: class {
  func clickBulb(bulbName: String)
  func getBulbs() -> [Bulb]
  func getGroups() -> [Group]
  func test()
  func groupSelected(groupSelected: Bool)
  func selectedBulbs(bulbs: [Bulb])
}


extension UIViewController {
  
  private struct customProperties{
    static var bulbCollection:[Bulb] = []
    static var groupCollection:[Group] = []
  }
  var bulbCollection:[Bulb] {
    get {
      return customProperties.bulbCollection
      
    } set {
        customProperties.bulbCollection = newValue
    }
  }
  
  var groupCollection: [Group] {
    get {
      return customProperties.groupCollection
    } set {
      customProperties.groupCollection = newValue
    }
  }
  
  
  
  
  // Delegate functions
  func clickBulb(bulbName: String){
    performSegue(withIdentifier: "NameLightSegue", sender: nil)
  }
  
  
  func getBulbs() -> [Bulb]{
    return self.bulbCollection
  }
  
  func getGroups() -> [Group]{
    return self.groupCollection
  }
  
  
  func test() {
    print("test")
  }
  


  
}
