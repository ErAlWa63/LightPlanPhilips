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
        LightType(name: "Dining",     file: "Dining.png"),
        LightType(name: "Floorstand", file: "Floorstand.png"),
        LightType(name: "Pendant",    file: "Pendant.png")]
    
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
