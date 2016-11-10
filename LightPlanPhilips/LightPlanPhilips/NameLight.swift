//
//  NameLight.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 10/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class NameLight: NSObject {
    var name           : String
    var lightTypeIndex : Int
    
    init(name: String, lightTypeIndex: Int) {
        self.name           = name
        self.lightTypeIndex = lightTypeIndex
    }
}
