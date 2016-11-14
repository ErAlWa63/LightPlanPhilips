//
//  PLPOrangeButton.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 11/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class PLPOrangeButton: PLPButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    basics()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    basics()
  }
  
  private func basics () {
    layer.backgroundColor = UIColorFromRGB(rgbValue: 0xEB8301).cgColor
  }
  
}
