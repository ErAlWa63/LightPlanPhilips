//
//  DataSource.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 10-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import Foundation

class DataSource: NSObject {
    static let sharedInstance = DataSource()
    
    func GetBulbs() -> [Bulb] {
        
        var bulbCollection: [Bulb] = []
        
        
        let bulb1 = Bulb(name: "bulb1")
        bulb1.positionX = 0
        bulb1.positionY = 0
        bulbCollection.append(bulb1)
        let bulb2 = Bulb(name: "bulb2")
        bulb2.positionX = 100
        bulb2.positionY = 100
        let bulb3 = Bulb(name: "bulb3")
        bulb3.positionX = -100
        bulb3.positionY = -100
        
        
        return bulbCollection
    }
}

