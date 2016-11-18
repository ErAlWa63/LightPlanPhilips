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
  func test()
  func groupSelected(groupSelected: Bool)
  func selectedBulbs(bulbs: [Bulb])
}


extension UIViewController {
  
  private struct customProperties{
    static var bulbCollection:[Bulb] = []
  }
  var bulbCollection:[Bulb] {
    get {
      return customProperties.bulbCollection
      
    } set {
        customProperties.bulbCollection = newValue
    }
  }
  
  // Delegate functions
  func clickBulb(bulbName: String){
    print(bulbName)
    performSegue(withIdentifier: "NameLightSegue", sender: nil)
  }
  
  
  func getBulbs() -> [Bulb]{
    return self.bulbCollection
  }
  
  
  func test() {
    print("test")
  }
  


  
}
