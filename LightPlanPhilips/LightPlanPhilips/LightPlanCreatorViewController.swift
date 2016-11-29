//
//  LightPlanCreatorViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 22/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class LightPlanCreatorViewController: UIViewController {
  private var myHome : Home?
  
  @IBAction private func startButton(_ sender: Any) {
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    passDataToNextScene(segue: segue)
  }
  
  private func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "MyRoomSegue" {
      passDataToSomewhereScene(segue: segue)
    }
  }
  
  private func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    if let destination = segue.destination as? MyRoomViewController {
      passDataToScene( destination: destination)
    }
  }
  
  private func passDataToScene (destination: MyRoomViewController) {
    if let myHome = myHome {
      destination.destinationMyHome = myHome
//      destination.closureToPerform = { [weak self] (myHome: MyHome) in
////        if let strongSelf = self {
//////          if var myHome = strongSelf.myHome {
//////            // myHome.room = rooms
//////          }
////        }
//      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    DataSource.sharedInstance.createData()
    myHome = DataSource.sharedInstance.myHome
  }
}
