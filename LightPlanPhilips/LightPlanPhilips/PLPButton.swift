//
//  PLPButton.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 11/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// http://stackoverflow.com/questions/27079681/how-to-init-a-uibutton-subclass
//   5. Create your UIButton subclass with a default property value for your property
//
// https://gist.github.com/rajohns08/ead7981593181033d75f
//   iOS / Swift - IBDesignable and IBInspectable working example for a UIButton subclass with a border
//
// http://stackoverflow.com/questions/24074257/how-to-use-uicolorfromrgb-value-in-swift
//

import UIKit

class PLPButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    basics()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    basics()
  }
  
  private func basics () {
//    layer.cornerRadius = 5
//    layer.masksToBounds = true
//    layer.borderWidth = 1
//    layer.borderColor = UIColor.darkGray.cgColor
//    layer.shadowColor = UIColor.lightGray.cgColor
//    layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    tintColor = UIColor.white
    frame = CGRect(x: 10, y: 10, width: 10, height: 10)
  }
  
  override func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }

}
