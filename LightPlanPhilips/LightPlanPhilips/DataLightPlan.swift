//
//  DataLightPlan.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 09/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class DataLightPlan: NSObject {
  static let  sharedInstance = DataLightPlan()
  
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
    Lamp(name: "Bulb 1"),
    Lamp(name: "Bulb 2"),
    Lamp(name: "Bulb 3"),
    Lamp(name: "Bulb 4"),
    Lamp(name: "Bulb 5"),
    Lamp(name: "Bulb 6")]
  
  func loadLightPlan() {
    
  }
  
}
