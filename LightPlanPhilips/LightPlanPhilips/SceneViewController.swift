//
//  SceneViewController.swift
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


class SceneViewController: UIViewController , RoomSceneDelegate {
  // maak hier alle functies in die je wilt, en voeg variabelen toe
//  private struct customProperties{
//    static var bulbCollection:[Bulb] = []
//    static var groupCollection:[Group] = []
//  }
//  var bulbCollection:[Bulb] {
//    get {
//      return customProperties.bulbCollection
//      
//    } set {
//        customProperties.bulbCollection = newValue
//    }
//  }
//  
//  var groupCollection: [Group] {
//    get {
//      return customProperties.groupCollection
//    } set {
//      customProperties.groupCollection = newValue
//    }
//  }
  
  func groupSelected(groupSelected: Bool) {
    assert(false, "Implement this in subclass")
  }
  
  func selectedBulbs(bulbs: [Bulb]) {
    assert(false, "Implement this in subclass")
  }
  
  // Delegate functions
  func clickBulb(bulbName: String){
    performSegue(withIdentifier: "NameLightSegue", sender: nil)
  }
  
  func clickGroup(groupName: String){
    performSegue(withIdentifier: "", sender: nil)
  }
  
 
  
  
  func test() {
    print("test")
  }
  
  
  func getBulbs() -> [Bulb]{
   return [] //self.bulbCollection
  }
  
  
  
  
  func getGroups() -> [Group]{
    return [] //self.groupCollection
  }


  
}
