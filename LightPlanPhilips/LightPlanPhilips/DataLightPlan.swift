//
//  DataLightPlan.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 09/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit


//struct Home {
//  var room : [Room] = []
//}

//struct Room {
//  var name        : String
//  var description : String
//  var pictogram   : UIImage
//  
//  init(name: String, description: String, file: String) {
//    self.name        = name
//    self.description = description
//    self.pictogram   = UIImage(named: file)!
//  }
//}


struct BulbX {
  var name        : String  // e.g. Bulb 1
  var pictogram   : UIImage
  //  var room        : Int
  
}



struct Lamp {
  var name      : String
  var pictogram : UIImage
  var nameLight : NameLight?
  
  init(name: String, file: String) {
    self.name      = name
    self.pictogram = UIImage(named: file)!
    self.nameLight = nil
  }
  
  init(name: String, file: String, nameLight: NameLight) {
    self.name      = name
    self.pictogram = UIImage(named: file)!
    self.nameLight = nameLight
  }
}


class DataLightPlan: NSObject {
  static let  sharedInstance = DataLightPlan()
  private override init () {}
  let debug = Debug() // debugger functionality
  
  var myHome = Home()
  
  var listLightType = [
    LightType(name: "Ceiling",                 file: "ceiling.png"),
    LightType(name: "Floor",                   file: "floor.png"),
    LightType(name: "Pendant",                 file: "pendant.png"),
    LightType(name: "Rec spot",                file: "rec_spot.png"),
    LightType(name: "Spot",                    file: "spot.png"),
    LightType(name: "Table",                   file: "table.png")]
  
  
  var listLamp = [
    Lamp(name: "Bulb 1", file: "br30_slim.png"),
    Lamp(name: "Bulb 2", file: "br30_slim.png")]
  
  func loadLightPlan() {
  }
  
}
