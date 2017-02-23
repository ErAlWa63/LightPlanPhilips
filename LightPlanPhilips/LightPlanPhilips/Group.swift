//
//  Group.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class Group {
  var id: String
  var name: String
  var assignedBulbs: [Bulb] = []
  var groupTypeName: String?
  var groupTypeIcon: UIImage?
  var isArea: Bool = true
  var positionX: Float?
  var positionY: Float?
  
  init (name: String) {
    self.id =  UUID().uuidString
    self.name = name
  }
}
