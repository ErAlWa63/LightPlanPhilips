//
//  Room.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import Foundation
import UIKit


class Room {
  var id: String
  var name: String
  var description: String?
  var pictogram: UIImage?
  var assignedBulbs: [Bulb] = []
  var groups: [Group] = []
  
  init(id: String, name: String) {
    self.id =  id
    self.name = name
  }
  init(id: String, name: String, file: String) {
    self.id =  id
    self.name = name
    self.pictogram   = UIImage(named: file)!
  }
  init(id: String, name: String, description: String, file: String) {
    self.id =  id
    self.name = name
    self.description = description
    self.pictogram   = UIImage(named: file)!
  }
}
