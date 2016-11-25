//
//  GroupLightsViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit
import SpriteKit







class GroupBulbsViewController: SceneViewController, UITextFieldDelegate {
  
  
  var groupId: String = ""
  var bulbCollection: [Bulb] = []
  var groupCollection: [Group] = []
 //var roomId: String = "b5e23af6-f955-4802-9c89-990e71a48f2a"
  var roomId: String = ""
  
  @IBOutlet weak var groupName: UITextField!
  
  @IBAction func cancelButton(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var isArea: UIButton!
  
  @IBAction func isArea(_ sender: Any) {
    if isArea.currentTitle == "☐" {
      isArea.setTitle("☒", for: .normal)
    } else {
      isArea.setTitle("☐", for: .normal)
    }
  }
  
  
  @IBOutlet weak var createGroup: UIButton!
  
  
  @IBAction func groupNameChanged(_ sender: Any) {
    if groupName.text != "" {
      groupNameFilled = true
    } else {
      groupNameFilled = false
    }
    enableDisableButton()
    
    
  }
  
  
  @IBAction func createGroup(_ sender: Any) {
    
    let newId: String = UUID().uuidString
 

    //let group = Group(id: newId, name: groupName.text!)
    // add group to room
    //DataSource.sharedInstance.addGroupToRoom(roomId: roomId, group: group)
    
    
    // get group position
    var positionX: Float = 0
    var positionY: Float = 0
    let numberInGroup: Float = Float(selectedBulbs.count)
    
    
    // get all bulbs in group
    for bulb in selectedBulbs {
      positionX += bulb.positionX!
      positionY += bulb.positionY!
      
      DataSource.sharedInstance.moveBulbFromRoomToGroup(bulbId: bulb.id, groupId: newId)
    }
    
    //positionX = positionX / numberInGroup
    //positionY = positionY / numberInGroup
    
    
    group.positionX = positionX / numberInGroup
    group.positionY = positionY / numberInGroup
  
    
    dismiss(animated: true, completion: nil)
  }
  
  
  
  
  var groupSelected: Bool = false
  var groupNameFilled: Bool = false
  var selectedBulbs: [Bulb] = []
  
  
  var scene: RoomScene!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    

  }
  
  override func viewWillAppear(_ animated: Bool) {
    bulbCollection = DataSource.sharedInstance.getBulbsInRoom(roomId: roomId)
    print("group view \(self.bulbCollection)")
    
    self.groupName.delegate = self
    
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
  
  
  
  // dismiss keyboard when return is pressed
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  
  func enableDisableButton() {
    if self.groupSelected && self.groupNameFilled {
      createGroup.isHidden = false
    } else {
      createGroup.isHidden = true
    }
  }
  
  
  // delegate function
  override func groupSelected(groupSelected: Bool) {
    self.groupSelected = groupSelected
    enableDisableButton()
  }
  
  
  override func selectedBulbs(bulbs: [Bulb]) {
    
    
    self.selectedBulbs = bulbs
  }
  
  override func getBulbs() -> [Bulb]{
    return self.bulbCollection
  }

  override func getGroups() -> [Group]{
    return []
  }
}
