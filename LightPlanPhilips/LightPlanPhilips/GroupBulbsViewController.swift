//
//  GroupLightsViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit
import SpriteKit







class GroupBulbsViewController: UIViewController,RoomSceneDelegate {
  
  
    @IBAction func cancelButton(_ sender: Any) {
      
          dismiss(animated: true, completion: nil)
    }
  
  var bulbCollection: [Bulb] = []

  
  var scene: RoomScene!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
  
 
      scene.roomSceneDelegate = self
      
      view.presentScene(scene)
      
      scene.dragDropEnabled = false
      scene.createGroup = true
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
    
    
  }
  
  // Delegate functions
  func clickBulb(bulbName: String){
    print(bulbName)
    performSegue(withIdentifier: "NameLightSegue", sender: nil)
    
  }
  
  
  func getBulbs() -> [Bulb]{
    
    return self.bulbCollection
    
  }
  
  
  func test() {
    print("test1")
  }
  
  
  func clickGroup(groupName: String) {
    
    
    
  }
  
  
  
}
