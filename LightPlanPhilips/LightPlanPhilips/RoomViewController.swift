//
//  RoomViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//



import UIKit
import SpriteKit

protocol RoomSceneDelegate: class {
  func showAlertMessage(bulb: String) -> String
  func clickBulb(bulbName: String)
  func clickGroup(groupName: String)
}


class RoomViewController: UIViewController, RoomSceneDelegate {
  
  let d = D() // debugger functionality
  @IBOutlet weak var test1Button: UIButton!
  @IBOutlet weak var test2Button: UIButton!
  @IBOutlet weak var test3Button: UIButton!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    d.c(s: "\(#file) - prepare - start")
//    d.c(s: "\(#file) - prepare - segue.identifier - \(segue.identifier)")
//    d.c(m: "start", f: #file, fu: #function, l: #line)
////    d.c(s: "\(#file) - prepare - start")
////    d.c(s: "\(#file) - prepare - segue.identifier - \(segue.identifier)")
//    
    if(segue.identifier == "NameLightSegue") {
      let nameLightViewController = (segue.destination) as! NameLightViewController
      nameLightViewController.delegateLamp = DataLightPlan.sharedInstance.listLamp[0]
    }
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var scene: RoomScene
    
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
      view.presentScene(scene)
      
      scene.roomSceneDelegate = self
    
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
    
    
    
    test1Button.layer.borderColor  = UIColor.darkGray.cgColor
    test1Button.layer.borderWidth  = 0.5
    test1Button.layer.cornerRadius = 5
    test2Button.layer.borderColor  = UIColor.darkGray.cgColor
    test2Button.layer.borderWidth  = 0.5
    test2Button.layer.cornerRadius = 5
    test3Button.layer.borderColor  = UIColor.darkGray.cgColor
    test3Button.layer.borderWidth  = 0.5
    test3Button.layer.cornerRadius = 5
    

    
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  // Delegate functions
  func clickBulb(bulbName: String){
    print(bulbName)
      performSegue(withIdentifier: "NameLightSegue", sender: nil)
    
  }
  
  
  func clickGroup(groupName: String) {
    
  }
  
  func showAlertMessage(bulb: String) -> String {
    print("\(bulb) was clicked")
    return "test"
  }
}
