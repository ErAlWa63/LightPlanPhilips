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
  var area: Bool = false
  var groupTypeName: String?
  var groupTypeIcon: UIImage?
  var groupSelected: Bool = false
  var groupNameFilled: Bool = false
  var selectedBulbs: [Bulb] = []
  var scene: RoomScene!
  var room: Room?
  
  
  @IBOutlet weak var groupName: UITextField!
  
  @IBAction func cancelButton(_ sender: Any) {
    
    _ = navigationController?.popToRootViewController(animated: true)
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
    DataSource.sharedInstance.addGroupToRoom(roomId: (room?.id)!, group: group)
    
    
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
    
    
    
    let groupPosition = CGPoint(x: CGFloat(positionX / numberInGroup), y: CGFloat(positionY / numberInGroup))
    
    
    for node in scene.nodes(at: groupPosition){
      if node.name == "room" {
        if node.contains(groupPosition) {
          group.positionX = Float(groupPosition.x)
          group.positionY = Float(groupPosition.y)
        } else {
          group.positionX = group.assignedBulbs[0].positionX
          group.positionY = group.assignedBulbs[0].positionY
        }
      }
    }
    
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
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    
    bulbCollection = DataSource.sharedInstance.getBulbsInRoom(roomId: (room?.id)!)
    
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
  
  
  override func viewWillDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
  }
  
  
  func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      self.view.frame.origin.y -= keyboardSize.height
    }
  }
  
  func keyboardWillHide(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      self.view.frame.origin.y += keyboardSize.height
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

  override func getRoom() -> Room? {
    return self.room
  }

}
