//
//  LightPlanCreatorViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 22/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class LightPlanCreatorViewController: UIViewController {
  let d = D() // debugger functionality
  
  @IBAction func startButton(_ sender: Any) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
  }
}
