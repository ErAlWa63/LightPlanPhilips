//
//  ShowGroupViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 02-12-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//



import UIKit
import SpriteKit


class ShowGroupViewController: SceneViewController, UITextFieldDelegate {
  
  
  var groupId: String = ""
  var bulbCollection: [Bulb] = []

  var roomId: String = ""

  var groupTypeName: String?
  var groupTypeIcon: UIImage?
  var groupSelected: Bool = false
  var groupNameFilled: Bool = false
  var selectedBulbs: [Bulb] = []
  var scene: RoomScene!
  var room: Room?
  
  
  @IBOutlet weak var isArea: UIButton!

  @IBOutlet weak var groupName: UITextField!
  
  @IBOutlet weak var groupType: UIButton!
  

  @IBAction func removeGroup(_ sender: Any) {
    
    DataSource.sharedInstance.removeGroup(groupId: groupId)
    
    dismiss(animated: true, completion: nil)
  }

  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  



  override func viewDidLoad() {
    super.viewDidLoad()
    bulbCollection = DataSource.sharedInstance.getBulbsInGroup(groupId: groupId)
    
    let group = DataSource.sharedInstance.getGroup(groupId: groupId)
    
    groupName.text = group?.name
    groupType.setTitle("\((group?.groupTypeName)!) >", for: .normal)
    if (group?.isArea)! {
      isArea.setTitle("☒", for: .normal)
    } else {
      isArea.setTitle("☐", for: .normal)
    }
    
    
    
    
    
    
    
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.scaleMode = .aspectFill
      
      
      scene.roomSceneDelegate = self
      
      view.presentScene(scene)
      
      scene.dragDropEnabled = false
      scene.createGroup = false
      scene.noAction = true
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  


  
  
  override func getBulbs() -> [Bulb] {
    return bulbCollection
  }
  
  override func getRoom() -> Room? {
    return self.room
  }
  
  
}

