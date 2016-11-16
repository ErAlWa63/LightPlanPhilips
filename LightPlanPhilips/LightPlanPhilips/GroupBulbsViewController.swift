//
//  GroupLightsViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit
import SpriteKit






class GroupBulbsViewController: UIViewController {
  
  
    @IBAction func cancelButton(_ sender: Any) {
      
          dismiss(animated: true, completion: nil)
    }
  


  
    var scene: RoomScene!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
      view.presentScene(scene)
      
      //scene.roomSceneDelegate = self
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
    
    
  }
  
  
}
