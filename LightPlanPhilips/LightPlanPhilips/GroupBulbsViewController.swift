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
  var roomId: String = ""
  var area: Bool = false
  var groupTypeName: String?
  var groupTypeIcon: UIImage?
  var groupSelected: Bool = false
  var groupNameFilled: Bool = false
  var selectedBulbs: [Bulb] = []
  var scene: RoomScene!
  
  
  @IBOutlet weak var groupName: UITextField!
  
  @IBAction func cancelButton(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
  }
  @IBOutlet weak var chooseButton: UIButton!
  
  @IBOutlet weak var isArea: UIButton!
  
  @IBAction func isArea(_ sender: Any) {
    if isArea.currentTitle == "☐" {
      isArea.setTitle("☒", for: .normal)
      area = true
      chooseButton.setTitle("choose area >", for: .normal)
    } else {
      isArea.setTitle("☐", for: .normal)
      area = false
      chooseButton.setTitle("choose type >", for: .normal)
    }
    chooseButton.setImage(nil, for: .normal)
    groupTypeName = nil
    groupTypeIcon = nil
    enableDisableButton()
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
    
    var groupId: String
 
    //create room
    let group = Group(name: groupName.text!)
    
    groupId = group.id
    
     //add group to room
    DataSource.sharedInstance.addGroupToRoom(roomId: roomId, group: group)
    
    
    // get group position
    var positionX: Float = 0
    var positionY: Float = 0
    let numberInGroup: Float = Float(selectedBulbs.count)
    
    
    // get all bulbs in group
    for bulb in selectedBulbs {
      positionX += bulb.positionX
      positionY += bulb.positionY
      
      DataSource.sharedInstance.moveBulbFromRoomToGroup(bulbId: bulb.id, groupId: groupId)
    }
    
    group.positionX = positionX / numberInGroup
    group.positionY = positionY / numberInGroup
    group.groupTypeName = groupTypeName
    group.groupTypeIcon = groupTypeIcon
  
    dismiss(animated: true, completion: nil)
  }
  
  
  
  
  
  
  @IBAction func unwindToGroup(segue: UIStoryboardSegue) {
    if let svc = segue.source as? ChooseItemTableViewController {
      svc.area = area
      groupTypeName  = svc.itemName
      groupTypeIcon = svc.itemImage
      chooseButton.setTitle("   \(groupTypeName!) >", for: .normal)
      chooseButton.setImage(groupTypeIcon, for: .normal)
    }
    enableDisableButton()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ChooseItem" {
      let viewController = (segue.destination) as! ChooseItemTableViewController
      viewController.area = area

    }
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    bulbCollection = DataSource.sharedInstance.getBulbsInRoom(roomId: roomId)
    
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
    if self.groupSelected && self.groupNameFilled && groupTypeName != nil {
      createGroup.isHidden = false
    } else {
      createGroup.isHidden = true
    }
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // started typing, move view up
    self.view.frame.origin.y -= 250
    
  }
    
  func textFieldDidEndEditing(_ textField: UITextField) {
    // stopped typing, move view down
    self.view.frame.origin.y += 250
  }
  
  
  
  
  // delegate function
  override func groupSelected(groupSelected: Bool) {
    self.groupSelected = groupSelected
    enableDisableButton()
  }
  
  override func selectedBulbs(bulbs: [Bulb]) {
    self.selectedBulbs = bulbs
  }
  
  
  override func getBulbs() -> [Bulb] {
    return bulbCollection
  }


}
