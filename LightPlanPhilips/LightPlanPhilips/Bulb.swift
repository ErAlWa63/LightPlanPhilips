//
//  Bulb.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import Foundation

class Bulb {
  var name: String
  //    var bulbType: String?
  //    var lightType: String?
  //    var bulbIcon: String = "bulb.jpeg"
  var selected: Bool
  var positionX: Int?
  var positionY: Int?
  
  
  init (name: String) {
    self.name = name
    self.selected = true
  }
}
