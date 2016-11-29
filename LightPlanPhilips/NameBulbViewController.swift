//
//  NameBulbViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 29-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit
import SpriteKit



class NameBulbViewController: SceneViewController, UITextFieldDelegate {
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBOutlet weak var bulbName: UITextField!
  
  @IBOutlet weak var saveBulb: UIButton!
  
  @IBAction func saveBulb(_ sender: Any) {
    print(bulbName.text!)
    
    bulbCollection[0].name = bulbName.text!
    
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func nameChanged(_ sender: Any) {
    if bulbName.text != "" {
      saveBulb.isHidden = false
    } else {
      saveBulb.isHidden = true
    }
  }
  

  
  var scene: RoomScene!
  var bulbCollection: [Bulb] = []
  //var groupCollection: [Group] = []
  //var roomId: String = "b5e23af6-f955-4802-9c89-990e71a48f2a"
  var bulbId: String = ""
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    bulbCollection.append(DataSource.sharedInstance.getBulb(bulbId: bulbId)!)
    
    
    if bulbCollection[0].name != "" {
      self.bulbName.text = bulbCollection[0].name
    }
    
    self.bulbName.delegate = self
    
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
  

  // dismiss keyboard when return is pressed
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  // delegate functions
  override func groupSelected(groupSelected: Bool) {
    // not used here
  }
  override func selectedBulbs(bulbs: [Bulb]){
    
  }
  override func getBulbs() -> [Bulb]{
    return self.bulbCollection
  }
  
  
  
  
  
}
