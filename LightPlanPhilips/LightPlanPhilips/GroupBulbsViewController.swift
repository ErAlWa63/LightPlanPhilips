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
    
    
    @IBOutlet weak var creatGroup: UIButton!
    
    @IBAction func createGroup(_ sender: Any) {
        
        print("group")
    }
    
  var bulbCollection: [Bulb] = []

  
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

  // Delegate functions
  func clickBulb(bulbName: String){
    print(bulbName)
    performSegue(withIdentifier: "NameLightSegue", sender: nil)
  }
  
  
  func getBulbs() -> [Bulb]{
    return self.bulbCollection
  }
  
  
  func enableButton(button: UIButton) {
    button.isEnabled = true
  }
  
  
  func test() {
    print("test1")
  }
  
  
  func clickGroup(groupName: String) {
    
    
    
  }
  
  
  
}
