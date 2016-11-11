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

import UIKit

class PLPButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // set other operations after super.init, if required
//    backgroundColor = UIColor.init(ciColor: CIColor(
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    // set other operations after super.init if required
//    backgroundColor = .redColor()
  }
}
