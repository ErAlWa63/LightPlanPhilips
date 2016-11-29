//
//  Group.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import Foundation

class Group {
  var id: String
  var name: String
  var bulbs: [Bulb]
  var groupType : String?
  var isArea: Bool = true
  var positionX: Float?
  var positionY: Float?
  
  init (name: String) {
    self.id =  UUID().uuidString
    self.name = name
    bulbs = []
  }
}
