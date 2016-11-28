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
  var bulbs: [Bulb] = []
  var groups: [Group] = []

  init(name: String) {
    self.id =  UUID().uuidString
    self.name = name
  }
}
