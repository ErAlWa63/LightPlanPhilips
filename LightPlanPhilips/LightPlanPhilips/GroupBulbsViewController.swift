//
//  GroupLightsViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 16-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit
import SpriteKit







class GroupBulbsViewController: UIViewController,RoomSceneDelegate, UITextFieldDelegate {
  
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
    
    // create group
    let group = Group(name: groupName.text!, bulbs: selectedBulbs)
    
    // get group position
    var positionX: Float = 0
    var positionY: Float = 0
    let numberInGroup: Float = Float(selectedBulbs.count)

    for bulb in group.bulbs {
      positionX += bulb.positionX!
      positionY += bulb.positionY!
    }
    
    positionX = positionX / numberInGroup
    positionY = positionY / numberInGroup
    
    
    group.positionX = positionX
    group.positionY = positionY
    
    groupCollection.append(group)
    
    // remove groupbulbs from bulbcollection
    var index: Int = 0
  
    for bulbinCollection in self.bulbCollection {
      
      for bulbInGroup in group.bulbs {
        if bulbInGroup.name == bulbinCollection.name {
          bulbCollection.remove(at: index)
          index -= 1
        }
      }
      index += 1
    }
    

    
    dismiss(animated: true, completion: nil)
  }
  
  
  
  
  var groupSelected: Bool = false
  var groupNameFilled: Bool = false
  var selectedBulbs: [Bulb] = []
  
  
  var scene: RoomScene!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
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
  func groupSelected(groupSelected: Bool) {
    self.groupSelected = groupSelected
    enableDisableButton()
  }
  
  
  func selectedBulbs(bulbs: [Bulb]) {
    
    
    self.selectedBulbs = bulbs
  }
}
