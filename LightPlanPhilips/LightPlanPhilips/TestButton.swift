//
//  TestButton.swift
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

import UIKit

class TestButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    basics()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    basics()
  }
  
  private func basics () {
    layer.cornerRadius = 5
    layer.masksToBounds = true
    layer.borderWidth = 1
    layer.borderColor = UIColor.darkGray.cgColor
    layer.backgroundColor = UIColor.green.cgColor
  }
}
