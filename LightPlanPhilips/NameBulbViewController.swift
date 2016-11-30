//
//  NameBulbViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 29-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit
import SpriteKit


// press cancel
class NameBulbViewController: SceneViewController, UITextFieldDelegate {
  @IBAction func cancelButton(_ sender: Any) {
    bulb.lightTypeName = tempLightTypeName
    bulb.lightTypeIcon = tempLightTypeIcon
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBOutlet weak var bulbName: UITextField!
  
  @IBOutlet weak var saveBulb: UIButton!
  
  @IBOutlet weak var lightType: UIButton!
  
  
  @IBAction func saveBulb(_ sender: Any) {
    print(bulbName.text!)
    
    bulb.name = bulbName.text!
    
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func nameChanged(_ sender: Any) {
    if bulbName.text != "" {
      if bulb.lightTypeName != nil {
        saveBulb.isHidden = false
      } else {
        saveBulb.isHidden = true
      }
    } else {
      saveBulb.isHidden = true
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "chooseType") {
      tempName = bulbName.text
      let lightTypeCollectionViewController = (segue.destination) as! LightTypeCollectionViewController
      lightTypeCollectionViewController.bulb = bulb
    }
  }
  
  
  
  @IBAction func chooseType(_ sender: Any) {
  }
  
  
  var scene: RoomScene!
  var bulb: Bulb!
  var bulbId: String = ""
  var tempName: String?
  var tempLightTypeName: String?
  var tempLightTypeIcon: UIImage?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    
    
    bulb = DataSource.sharedInstance.getBulb(bulbId: bulbId)!
    
    
    // save temp lighttype
    if bulb.lightTypeName != nil, tempLightTypeName == nil {
      tempLightTypeName = bulb.lightTypeName
      tempLightTypeIcon = bulb.lightTypeIcon
    }
    
    // enable save button if name is filled and lighttype selected
    if self.bulbName.text != nil, bulb.lightTypeName != nil {
      saveBulb.isHidden = false
    }
    
    // fill name when returning from lighttype collection view
    if bulb.name != "" {
      if tempName != nil {
        self.bulbName.text = tempName
      } else {
        self.bulbName.text = bulb.name
      }
    }
    
    // fil choose lighttype button
    if bulb.lightTypeName == nil {
      lightType.setTitle("choose type >", for: UIControlState.normal)
    } else {
      lightType.setImage(bulb.lightTypeIcon, for: UIControlState.normal)
      lightType.setTitle("   \(bulb.lightTypeName!) >", for: UIControlState.normal)
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
      scene.noAction = true
      
      view.ignoresSiblingOrder = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // started typing, move view up
    self.view.frame.origin.y -= 100
    
  }
  
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    // stopped typing, move view down
    self.view.frame.origin.y += 100
  }
  
  
  // dismiss keyboard when return is pressed
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  // delegate functions
  override func getBulbs() -> [Bulb] {
    var bulbs: [Bulb] = []
    bulbs.append(bulb)
    return bulbs
  }
}
