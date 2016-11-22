//
//  RoomViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//



import UIKit
import SpriteKit



class RoomViewController: UIViewController, RoomSceneDelegate {
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  var scene: RoomScene!
  //var bulbCollection: [Bulb] = []
  
  
  
  
  let d = D() // debugger functionality
  @IBOutlet weak var test1Button: UIButton!
  @IBOutlet weak var test2Button: UIButton!
  @IBOutlet weak var test3Button: UIButton!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if(segue.identifier == "NameLightSegue") {
      let nameLightViewController = (segue.destination) as! NameLightViewController
      nameLightViewController.delegateLamp = DataLightPlan.sharedInstance.listLamp[0]
    } else if (segue.identifier == "CreateGroup") {
      let groupBulbsViewController = (segue.destination) as! GroupBulbsViewController
      groupBulbsViewController.bulbCollection = bulbCollection
    }
  }
  
  //click group button
  @IBAction func groupClicked(_ sender: Any) {
        saveBulbs()
        //
    
    
    
    
        performSegue(withIdentifier: "CreateGroup", sender: nil)
  }
  

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bulbCollection = DataSource.sharedInstance.GetBulbs()
    

  }
  
  override func viewWillAppear(_ animated: Bool) {
    print(bulbCollection)
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
      
      scene.roomSceneDelegate = self
      view.presentScene(scene)
      
      scene.dragDropEnabled = false
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
  
  // delegate functions
  func groupSelected(groupSelected: Bool) {
  
  }
  func selectedBulbs(bulbs: [Bulb]){
    
  }
  

}
