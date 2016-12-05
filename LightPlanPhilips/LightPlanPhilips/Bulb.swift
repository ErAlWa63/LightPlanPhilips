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
  var positionX: Float = 0
  var positionY: Float = 0
  
  

  init () {
    self.id =  UUID().uuidString
    self.selected = true
  }
  
  init(name: String, image: UIImage){
    self.id =  UUID().uuidString
    self.selected = true
    self.lightTypeName = name
    self.lightTypeIcon = image
  }
  
  
  init( coordinateX: Float, coordinateY: Float) {
    self.id =  UUID().uuidString
    self.selected = true
    self.positionX = coordinateX
    self.positionY = coordinateY
  }
}



