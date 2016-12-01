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

// ====================================================================

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

  

//  func getHome () -> Home {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
//    myHome.room.append(Room(name: "Living room", description: "",                file: "br30_slim.png"))
//    myHome.room.append(Room(name: "Kitchen",     description: "",                file: "br30_slim.png"))
//    myHome.room.append(Room(name: "Bedroom",     description: "",                file: "br30_slim.png"))
//    myHome.room.append(Room(name: "Open space",  description: "Definable areas", file: "br30_slim.png"))
//    debug.console(message: "myHome = \(myHome)", file: #file, function: #function, line: #line)
//    return myHome
//  }


  
  var listLightType = [
    LightType(name: "br30 slim",               file: "br30_slim.png"),
    LightType(name: "ceiling",                 file: "ceiling.png"),
    LightType(name: "floor",                   file: "floor.png"),
    LightType(name: "go",                      file: "go.png"),
    LightType(name: "gu10 perfectfit",         file: "gu10_perfectfit.png"),
    LightType(name: "lichtstrip",              file: "lightstrip.png"),
    LightType(name: "pendant",                 file: "pendant.png"),
    LightType(name: "rec spot",                file: "rec_spot.png"),
    LightType(name: "spot",                    file: "spot.png"),
    LightType(name: "table",                   file: "table.png"),
    LightType(name: "white and color e27 b22", file: "white_and_color_e27_b22.png")]
  
  var listLamp = [
    Lamp(name: "Bulb 1", file: "br30_slim.png"),
    Lamp(name: "Bulb 2", file: "br30_slim.png")]
  
  func loadLightPlan() {
  }
  
  // =======================================================================================================================
  
}
