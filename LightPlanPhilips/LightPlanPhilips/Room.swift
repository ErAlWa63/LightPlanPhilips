//
//  Room.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// iOS Programming: The Big Nerd Ranch Guide pag 169 - Moving Rows


import Foundation
import UIKit


class Room {
  var id: String
  var name: String
  var description: String?
  var pictogram: UIImage?
  var assignedBulbs: [Bulb] = []
  var groups: [Group] = []
  var edge : [RoomShapeModel.Point] = []
  var gridCell  = Array(repeating: Bool(), count: 49)
  var countGridAxisX = [0, 0, 0, 0, 0, 0, 0]
  var countGridAxisY = [0, 0, 0, 0, 0, 0, 0]
  var countCell = 0
//  var currentCellIsCollored = Array(repeating: Bool(), count: 49)


  struct Point {
    var x: Int
    var y: Int
  }

  
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
  init(id: String, name: String, file: String, grid: [Bool]) {
    self.id =  id
    self.name = name
    self.pictogram   = UIImage(named: file)!
    self.gridCell = grid
  }
}
