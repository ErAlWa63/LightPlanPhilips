//
//  SelectRoomTypeViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 22/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class SelectRoomTypeViewController: UIViewController {
  let d = D() // debugger functionality
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func nextButton(_ sender: Any) {
  }
  
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    d.c(m: "start", f: #file, fu: #function, l: #line)
    
//    nextButton.isHidden = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    d.c(m: "start", f: #file, fu: #function, l: #line)
  }
}
