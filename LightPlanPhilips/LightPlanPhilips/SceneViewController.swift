//
//  SceneViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 15-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit



protocol RoomSceneDelegate: class {
  func clickBulb(id: String, segue: String)
  func getBulbs() -> [Bulb]
  func getGroups() -> [Group]
  func getRoom() -> Room?
  func groupSelected(groupSelected: Bool)
  func selectedBulbs(bulbs: [Bulb])
}


class SceneViewController: UIViewController , RoomSceneDelegate {
  // maak hier alle functies in die je wilt, en voeg variabelen toe
  
  func groupSelected(groupSelected: Bool) {
    assert(false, "Implement this in subclass")
  }
  
  func selectedBulbs(bulbs: [Bulb]) {
    assert(false, "Implement this in subclass")
  }
  

  func clickBulb(id: String, segue: String){
    
    performSegue(withIdentifier: segue, sender: nil)
  }
  
  func clickGroup(groupName: String){
    performSegue(withIdentifier: "", sender: nil)
  }
  
  
  func getBulbs() -> [Bulb]{
   return [] //self.bulbCollection
  }
  
  func getRoom() -> Room? {
    return nil
  }
  
  func getGroups() -> [Group]{
    return [] //self.groupCollection
  }


  
}
