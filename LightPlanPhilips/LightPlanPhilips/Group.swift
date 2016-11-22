//
//  Group.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import Foundation

class Group {
  var name: String
  var bulbs: [Bulb]
  var groupType : String?
  var isArea: Bool = true
  var positionX: Float?
  var positionY: Float?
  
  
  init (name: String, bulbs: [Bulb]) {
    self.name = name
    self.bulbs = bulbs
  }
}
