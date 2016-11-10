//
//  Lamp.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 10/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class Lamp: NSObject {
    var name      : String
    var nameLight : NameLight?
    
    init(name: String) {
        self.name      = name
        self.nameLight = nil
    }
    
    init(name: String, nameLight: NameLight) {
        self.name      = name
        self.nameLight = nameLight
    }
}
