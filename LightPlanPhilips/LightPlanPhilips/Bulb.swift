//
//  Bulb.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class Bulb {
  var id: String
  var name: String = ""
  var lightTypeName: String?
  var lightTypeIcon: UIImage?
  var selected: Bool
  var positionX: Float?
  var positionY: Float?
  
  

  init () {
    self.id =  UUID().uuidString
    self.selected = true
  }
}



