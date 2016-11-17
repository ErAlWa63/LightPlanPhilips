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
  func clickBulb(bulbName: String)
  func clickGroup(groupName: String)
  func getBulbs() -> [Bulb]
  func test()
}


class RoomViewController: UIViewController, RoomSceneDelegate {
  
  var scene: RoomScene!
  var bulbCollection: [Bulb] = []
  
  
  
  
  let d = D() // debugger functionality
  @IBOutlet weak var test1Button: UIButton!
  @IBOutlet weak var test2Button: UIButton!
  @IBOutlet weak var test3Button: UIButton!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if(segue.identifier == "NameLightSegue") {
      let nameLightViewController = (segue.destination) as! NameLightViewController
      nameLightViewController.delegateLamp = DataLightPlan.sharedInstance.listLamp[0]
    }
  }
  
  //click group button
  @IBAction func groupClicked(_ sender: Any) {
        saveBulbs()
   
        performSegue(withIdentifier: "CreateGroup", sender: nil)
  }
  

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bulbCollection = DataSource.sharedInstance.GetBulbs()
    
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
      
      scene.roomSceneDelegate = self
      
      
      view.presentScene(scene)
      
 
      

      scene.dragDropEnabled = true
      scene.createGroup = false
      
      

      
      
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
    
    
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  
  
  
  

  
  func saveBulbs(){
    scene.enumerateChildNodes(withName: "//*", using:
      { (node, stop) -> Void in
        if node is SKSpriteNode { 
          for bulb in self.bulbCollection {
            if bulb.name == node.name {
              bulb.positionX = Float(node.position.x)
              bulb.positionY = Float(node.position.y)
              break
            }
          }
        }
    })
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
    print("test")
  }
  
  
  func clickGroup(groupName: String) {
    
    
    
  }
  

}
