//
//  SKNodeExtension.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 15-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import SpriteKit


extension SKNode {
  
  private struct CustomProperties {
    static var isSelected:Bool?
  }
  
  var isSelected:Bool? {
    get {
      return CustomProperties.isSelected
    }
    set {
      CustomProperties.isSelected = newValue
    }
  }
}
