//
//  TestSKViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 24/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// https://www.raywenderlich.com/145318/spritekit-swift-3-tutorial-beginners
//

import UIKit
import SpriteKit

class TestSKViewController: UIViewController {
  let debug = Debug() // debugger functionality
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  var scene: RoomScene!
  var myBulbCollection: [Bulb] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    debug.console(message: "start", file: #file, function: #function, line: #line)
    //myBulbCollection = [Bulb.init(id: 1, name: "bulb1", selected: false, positionX: 0, positionY: 0),
    //                    Bulb.init(id: 2, name: "bulb2", selected: false, positionX: 100, positionY: 100),
    //                    Bulb.init(id: 3, name: "bulb3", selected: false, positionX: -100, positionY: -100)]

  }
  
  override func viewWillAppear(_ animated: Bool) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    print(myBulbCollection)
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
      
      //      scene.roomSceneDelegate = self
      view.presentScene(scene)
      
      scene.dragDropEnabled = false
      scene.createGroup = false
      
      view.ignoresSiblingOrder = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  override var shouldAutorotate: Bool {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    return false
  }
  
  func saveBulbs(){
    debug.console(message: "start", file: #file, function: #function, line: #line)
    scene.enumerateChildNodes(withName: "//*", using:
      { (node, stop) -> Void in
        if node is SKSpriteNode {
          for bulb in self.myBulbCollection {
            if bulb.name == node.name {
              bulb.positionX = Float(node.position.x)
              bulb.positionY = Float(node.position.y)
              break
            }
          }
        }
    })
  }
  
  // delegate functions
  func groupSelected(groupSelected: Bool) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    // not used here
  }
  func selectedBulbs(bulbs: [Bulb]){
    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
}

//extension  TestSKViewController: RoomSceneDelegate {
//
//}
