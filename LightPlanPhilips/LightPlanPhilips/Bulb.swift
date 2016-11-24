//
//  Bulb.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import Foundation

class Bulb {
  var id: Int
  var name: String
  //    var bulbType: String?
  //    var lightType: String?
  //    var bulbIcon: String = "bulb.jpeg"
  var selected: Bool
  var positionX: Float?
  var positionY: Float?
  
  
  init (id: Int, name: String) {
    self.id = id
    self.name = name
    self.selected = true
  }
  init( id: Int, name: String, selected: Bool, positionX: Float, positionY: Float) {
    self.id = id
    self.name = name
    self.selected = true
    self.positionX = positionX
    self.positionY = positionY
  }
}
