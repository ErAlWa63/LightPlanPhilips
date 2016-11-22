//
//  RoomShapeViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 16/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class RoomShapeViewController: UIViewController {
  let d = D() // debugger functionality
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cellButton(_ sender: Any) {
    let cellButton = sender as! UIButton
    DataLightPlan.sharedInstance.processCell( index: Int(cellButton.currentTitle!)!) ? cellButton.color(rgbValue: 0xE7BF7E) : cellButton.color(rgbValue: 0xD8D8D8)
    nextButton.isHidden = DataLightPlan.sharedInstance.countCell > 0 ? false : true
  }
  
  @IBAction func nextButton(_ sender: Any) {
    DataLightPlan.sharedInstance.processNext()
  }
  
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    d.c(m: "start", f: #file, fu: #function, l: #line)

    DataLightPlan.sharedInstance.toggle = DataLightPlan.sharedInstance.toggle.map{ _ in false}
    nextButton.isHidden = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    d.c(m: "start", f: #file, fu: #function, l: #line)
  }
}

