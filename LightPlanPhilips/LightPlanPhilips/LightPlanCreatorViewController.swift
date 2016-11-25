//
//  LightPlanCreatorViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 22/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class LightPlanCreatorViewController: UIViewController {
  private let d = D() // debugger functionality
  
  private var myHome : Home?
  
  @IBAction private func startButton(_ sender: Any) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
    d.c(m: "segue.identifier = \(segue.identifier)", f: #file, fu: #function, l: #line)
    if(segue.identifier == "SelectRoomTypeSegue") {
      d.c(m: "SelectRoomTypeSegue", f: #file, fu: #function, l: #line)
      if let SelectRoomTypeViewController = segue.destination as? SelectRoomTypeViewController {
        d.c(m: "SelectRoomTypeViewController", f: #file, fu: #function, l: #line)
        if let myHome = myHome {
          d.c(m: "myHome", f: #file, fu: #function, l: #line)
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
    d.c(m: "start", f: #file, fu: #function, l: #line)

    //myHome = DataLightPlan.sharedInstance.getHome()
    
    DataSource.sharedInstance.createData()

  }
}
