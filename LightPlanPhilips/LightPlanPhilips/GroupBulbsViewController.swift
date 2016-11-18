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
    
    print("group")
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
