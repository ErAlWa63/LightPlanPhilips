//
//  RoomViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//



import UIKit
import SpriteKit



class RoomViewController: SceneViewController {
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  var scene: RoomScene!
  var bulbCollection: [Bulb] = []
  var groupCollection: [Group] = []
  var roomId: String = "b5e23af6-f955-4802-9c89-990e71a48f2a"
  var bulbId: String = ""
  
  
  let d = D() // debugger functionality

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    

    if(segue.identifier == "NameBulb") {

      let nameBulbViewController = (segue.destination) as! NameBulbViewController
      nameBulbViewController.bulbId = bulbId
      
      
      
      
    } else if (segue.identifier == "CreateGroup") {
      let groupBulbsViewController = (segue.destination) as! GroupBulbsViewController
      groupBulbsViewController.roomId = roomId
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
    
        
    

  }
  
  override func viewWillAppear(_ animated: Bool) {
    bulbCollection = DataSource.sharedInstance.getBulbsInRoom(roomId: roomId)
    groupCollection = DataSource.sharedInstance.getGroupsInRoom(roomId: roomId)
    

    
    print(bulbCollection)
    print(groupCollection)
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
  override   func clickBulb(id: String, segue: String){
    self.bulbId = id
    performSegue(withIdentifier: segue, sender: nil)
  }
  
  
  
  
  
  
  override func groupSelected(groupSelected: Bool) {
    // not used here
  }
  override func selectedBulbs(bulbs: [Bulb]){
    
  }
  override func getBulbs() -> [Bulb]{
    return self.bulbCollection
  }

  override func getGroups() -> [Group]{
    return self.groupCollection
  }

  
  
}
