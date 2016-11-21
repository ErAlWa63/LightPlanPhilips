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
        
        
      let bulb1 = Bulb(id: 1, name: "bulb1")
        bulb1.positionX = 0
        bulb1.positionY = 0
        bulbCollection.append(bulb1)
        let bulb2 = Bulb(id: 2,name: "bulb2")
        bulb2.positionX = 100
        bulb2.positionY = 100
        bulbCollection.append(bulb2)
        let bulb3 = Bulb(id: 3,name: "bulb3")
        bulb3.positionX = -100
        bulb3.positionY = -100
        bulbCollection.append(bulb3)
        return bulbCollection
    }
}

