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
  
  var scene: RoomScene!
  var bulbCollection: [Bulb] = []
  var groupCollection: [Group] = []
  var bulbId: String = ""
  var room: Room?
  let debug = Debug() // debugger functionality
  
  
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  
  @IBAction func doneButton(_ sender: Any) {
    self.myHome = DataSource.sharedInstance.myHome
    _ = navigationController?.popToRootViewController(animated: true)
    
  }
  
  
  @IBAction func backButton(_ sender: Any) {
    _ = navigationController?.popViewController(animated: true)
  }
  @IBAction func cancelButton(_ sender: Any) {
    _ = navigationController?.popToRootViewController(animated: true)
  }
  

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    if(segue.identifier == "NameBulb") {
      
      let nameBulbViewController = (segue.destination) as! NameBulbViewController
      nameBulbViewController.bulbId = bulbId
      nameBulbViewController.room = self.room
    } else if (segue.identifier == "CreateGroup") {
      let groupBulbsViewController = (segue.destination) as! GroupBulbsViewController
      groupBulbsViewController.room = self.room
    } else if (segue.identifier == "ShowGroup") {
      let showGroupViewController = (segue.destination) as! ShowGroupViewController
      showGroupViewController.groupId = bulbId
      showGroupViewController.room = self.room
    }
  }
  
  //click group button
  @IBAction func groupClicked(_ sender: Any) {
    performSegue(withIdentifier: "CreateGroup", sender: nil)
  }
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    bulbCollection = DataSource.sharedInstance.getBulbsInRoom(roomId: (room?.id)!)
    groupCollection = DataSource.sharedInstance.getGroupsInRoom(roomId: (room?.id)!)
    
    
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
      
      scene.roomSceneDelegate = self
      view.presentScene(scene)
      
      scene.dragDropEnabled = false
      scene.createGroup = false
      
      view.ignoresSiblingOrder = true
      view.showsFPS = false
      view.showsNodeCount = false
    }
  }
  
  override var shouldAutorotate: Bool {
    return false
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
  
  override func getRoom() -> Room? {
    return self.room
  }
  
  
}
