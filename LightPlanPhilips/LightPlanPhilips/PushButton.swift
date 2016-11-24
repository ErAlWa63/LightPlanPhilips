//
//  PushButton.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 23/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class PushButton: UIButton {

  override func draw(_ rect: CGRect) {
    var path = UIBezierPath(ovalIn: rect)
    UIColor.green.setFill()
    path.fill()
  }
  
}
