//
//  Extension UIButton.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 22/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

extension UIButton {
  func color( rgbValue: UInt) {
    backgroundColor = UIColorFromRGB(rgbValue: rgbValue)
    setTitleColor(UIColorFromRGB(rgbValue: rgbValue), for: .normal)
  }
  
  private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor( red: CGFloat((rgbValue >> 16) & 0xFF) / 255.0, green: CGFloat((rgbValue >> 8) & 0xFF) / 255.0, blue: CGFloat(rgbValue & 0xFF) / 255.0, alpha: CGFloat(1.0))
  }
}
