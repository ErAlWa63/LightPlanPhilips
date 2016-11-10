//
//  LightType.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 09/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class LightType: NSObject {
    var name      : String
    var pictogram : UIImage
    
    init(name: String, file: String) {
        self.name      = name
        self.pictogram = UIImage(named: file)!
    }
}
