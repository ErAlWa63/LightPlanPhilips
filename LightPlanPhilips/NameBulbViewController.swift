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

  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  var scene: RoomScene!
  var bulb: Bulb!
  var bulbId: String = ""
  var tempName: String?
  var tempLightTypeName: String?
  var tempLightTypeIcon: UIImage?
  var room: Room?

  
  @IBOutlet weak var bulbName: UITextField!
  
  @IBOutlet weak var saveBulb: UIButton!
  
  @IBOutlet weak var lightType: UIButton!
  
  
  @IBAction func saveBulb(_ sender: Any) {
    bulb.name = bulbName.text!

    _ = navigationController?.popViewController(animated: true)
    
  }
  
  
  @IBAction func nameChanged(_ sender: Any) {
    if bulbName.text != "" {
        saveBulb.isHidden = false
    } else {
      saveBulb.isHidden = true
    }
  }
  
  @IBAction func backButton(_ sender: Any) {
    
    bulb.lightTypeName = tempLightTypeName
    bulb.lightTypeIcon = tempLightTypeIcon
    
    _ = navigationController?.popViewController(animated: true)
  }
  
  
  
  @IBAction func cancelButton(_ sender: Any) {
    
    _ = navigationController?.popToRootViewController(animated: true)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "chooseType") {
      
      view.endEditing(true)
      tempName = bulbName.text
      let lightTypeCollectionViewController = (segue.destination) as! LightTypeCollectionViewController
      lightTypeCollectionViewController.bulb = bulb
    }
  }
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)

  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    
    bulb = DataSource.sharedInstance.getBulb(bulbId: bulbId)!
    
    
    // save temp lighttype
    if bulb.lightTypeName != nil, tempLightTypeName == nil {
      tempLightTypeName = bulb.lightTypeName
      tempLightTypeIcon = bulb.lightTypeIcon
    }
    
    
    
    if bulbName.text == "" {
      self.saveBulb.isHidden = true
    } else {
      self.saveBulb.isHidden = false
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
      view.showsFPS = false
      view.showsNodeCount = false
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
  
  
  
  
  override var shouldAutorotate: Bool {
    return false
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
  
  override func getRoom() -> Room? {
    return self.room
  }
}
