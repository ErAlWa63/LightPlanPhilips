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
  var bulbs: [Bulb] = []
  var groupType : String
  //var groupIcon: String = "bulbs.jpeg"
  var isArea: Bool = true
  var positionX: Int?
  var positionY: Int?
  
  
  init (name: String, groupType: String) {
    self.name = name
    self.groupType = groupType
  }
}
