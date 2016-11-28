//
//  LightPlanCreatorViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 22/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class LightPlanCreatorViewController: UIViewController {
  private let debug = Debug() // debugger functionality
  
  private var myHome : Home?
  
  @IBAction private func startButton(_ sender: Any) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    debug.console(message: "segue.identifier = \(segue.identifier)", file: #file, function: #function, line: #line)
    if(segue.identifier == "SelectRoomTypeSegue") {
      debug.console(message: "SelectRoomTypeSegue", file: #file, function: #function, line: #line)
      if let SelectRoomTypeViewController = segue.destination as? SelectRoomTypeViewController {
        debug.console(message: "SelectRoomTypeViewController", file: #file, function: #function, line: #line)
        if let myHome = myHome {
          debug.console(message: "myHome", file: #file, function: #function, line: #line)
          //SelectRoomTypeViewController.delegateRoom = myHome.room
          SelectRoomTypeViewController.closureToPerform = { [weak self] (rooms: [Room]) in
            if let strongSelf = self {
              if var myHome = strongSelf.myHome {
               // myHome.room = rooms
              }
            }
          }
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    debug.console(message: "start", file: #file, function: #function, line: #line)

    //myHome = DataLightPlan.sharedInstance.getHome()
    
    DataSource.sharedInstance.createData()

  }
}
