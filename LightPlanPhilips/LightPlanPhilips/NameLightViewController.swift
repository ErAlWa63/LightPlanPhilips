 //
 //  NameLightViewController.swift
 //  LightPlanPhilips
 //
 //  Created by Erik Waterham on 09/11/2016.
 //  Copyright © 2016 The App Academy. All rights reserved.
 //
 // Dropdown menu in xcode using picker view and textbox(swift):
 //   https://www.youtube.com/watch?v=SfjZwgxlwcc&feature=youtu.be
 //   http://stackoverflow.com/questions/30319718/making-a-drop-down-list-using-swift/38666026#38666026
 //
 // How can I get images to appear in UI PickerView Component in Swift?
 //   http://stackoverflow.com/questions/27769246/how-can-i-get-images-to-appear-in-ui-pickerview-component-in-swift
 //
 // Extra protocol repairs conform Swift 3
 //
 // http://stackoverflow.com/questions/28919450/how-to-add-a-border-to-a-uipickerview
 // http://stackoverflow.com/questions/37620867/swift-error-cant-assign-value-of-type-uicolor-to-type-cgcolor
 //
 // http://stackoverflow.com/questions/26089152/sending-data-with-segue-with-swift (1. The boxing style)
 //
 // http://stackoverflow.com/questions/25917693/swift-how-to-set-a-default-value-of-a-uipickerview-with-three-components-in-swi
 //
 // http://stackoverflow.com/questions/4201959/label-under-image-in-uibutton
 //
 // http://stackoverflow.com/questions/24468336/how-to-correctly-handle-weak-self-in-swift-blocks-with-arguments (NatashaTheRobot)
 //
 
 import UIKit
 
 class NameLightViewController : UIViewController {
  let d = D() // debugger functionality
  
  var delegateLamp      :     Lamp!
  var temporaryNameLight:     NameLight!
  var delegateLightTypeIndex: Int?
  var firstTime = true
  
  @IBOutlet weak var nameLightType:         UITextField!
  @IBOutlet weak var removeButton:          UIButton!
  @IBOutlet weak var saveButton:            UIButton!
  @IBOutlet weak var chooseLightTypeButton: UIButton!
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func removeButton(_ sender: Any) {
    if var delegateLamp = delegateLamp {
      delegateLamp.nameLight = nil
    }
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveButton(_ sender: Any) {
    if var delegateLamp = delegateLamp {
      if let temporaryNameLight = temporaryNameLight {
        delegateLamp.nameLight = temporaryNameLight
      }
    }
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func chooseLightTypeButton(_ sender: Any) {
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "LightTypeSegue") {
      if let LightTypeCollectionViewController = segue.destination as? LightTypeCollectionViewController {
        LightTypeCollectionViewController.delegateLightTypeIndex = delegateLightTypeIndex
        LightTypeCollectionViewController.closureToPerform = { [weak self] (index: Int) in
          if let strongSelf = self {
            strongSelf.delegateLightTypeIndex = index
          }
        }
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
    if let temporaryNameLight = temporaryNameLight {
      if let delegateLightTypeIndex = delegateLightTypeIndex {
        temporaryNameLight.lightTypeIndex = delegateLightTypeIndex
        chooseLightTypeButton.contentEdgeInsets  = UIEdgeInsetsMake(0, -90, 0, 0)
        chooseLightTypeButton.titleEdgeInsets    = UIEdgeInsetsMake(0,  20, 0, 0)
        chooseLightTypeButton.setImage(DataLightPlan.sharedInstance.listLightType[temporaryNameLight.lightTypeIndex].pictogram, for: .normal)
        chooseLightTypeButton.setTitle(DataLightPlan.sharedInstance.listLightType[temporaryNameLight.lightTypeIndex].name, for: .normal)
        if firstTime {
          firstTime = false
        } else {
          saveButton.isHidden = false
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    d.c(m: "start", f: #file, fu: #function, l: #line)
    nameLightType.delegate                   = self
    chooseLightTypeButton.layer.borderColor  = UIColor.lightGray.cgColor
    chooseLightTypeButton.layer.borderWidth  = 0.5
    chooseLightTypeButton.layer.cornerRadius = 5
    chooseLightTypeButton.tintColor          = UIColor.black
    chooseLightTypeButton.contentEdgeInsets  = UIEdgeInsetsMake(0, -90, 0, 0)
    chooseLightTypeButton.titleEdgeInsets    = UIEdgeInsetsMake(0,  20, 0, 0)
    if let delegateLamp = delegateLamp {
      if let nameLight = delegateLamp.nameLight {
        temporaryNameLight = NameLight(name: nameLight.name, lightTypeIndex: nameLight.lightTypeIndex)
        delegateLightTypeIndex = nameLight.lightTypeIndex
      } else {
        removeButton.isHidden = true
        saveButton.isHidden = true
        temporaryNameLight = NameLight(name: "< give name >", lightTypeIndex: 0)
      }
      if let temporaryNameLight = temporaryNameLight {
        nameLightType.text = temporaryNameLight.name
        delegateLightTypeIndex = temporaryNameLight.lightTypeIndex
        if delegateLightTypeIndex == nil {
          nameLightType.text = "< give name >"
          chooseLightTypeButton.setTitle("< select light type >", for: .normal)
          chooseLightTypeButton.setImage(nil, for: .normal)
        } else {
          chooseLightTypeButton.setImage(DataLightPlan.sharedInstance.listLightType[temporaryNameLight.lightTypeIndex].pictogram, for: .normal)
          chooseLightTypeButton.setTitle(DataLightPlan.sharedInstance.listLightType[temporaryNameLight.lightTypeIndex].name, for: .normal)
        }
      }
    } else {
      nameLightType.textColor = UIColor.red
      nameLightType.text = "< no single lamp selected >"
      removeButton.isHidden = true
      saveButton.isHidden = true
    }
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
    tapRecognizer.numberOfTapsRequired = 1
    self.view.addGestureRecognizer(tapRecognizer)
  }
  
  func handleSingleTap(recognizer: UITapGestureRecognizer) {
    self.view.endEditing(true)
  }
 }
 
 extension NameLightViewController: UITextFieldDelegate {
  public func textFieldDidEndEditing(_ textField: UITextField) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
    if delegateLamp != nil {
      if let nameLightType = nameLightType {
        saveButton.isHidden = false
        if let text = nameLightType.text {
          if let temporaryNameLight = temporaryNameLight {
            temporaryNameLight.name = text
          }
        }
      }
    }
    animateTextField(textField: textField, up: false, height: view.frame.size.height - textField.frame.origin.y - textField.frame.height - 20)
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if (delegateLamp) != nil {
      return true
    } else {
      return false
    }
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameLightType.resignFirstResponder()
    return true
  }
  
  func animateTextField(textField: UITextField, up: Bool, height: CGFloat) {
    UIView.beginAnimations("animateTextField", context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(0.0)
    self.view.frame = self.view.frame.offsetBy(dx: 0, dy: (up ? height - 200 : 200 - height))
    UIView.commitAnimations()
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    animateTextField(textField: textField, up: true, height: view.frame.size.height - textField.frame.origin.y - textField.frame.height - 20)
  }
  
////  func textFieldDidEndEditing(_ textField: UITextField) {
//    textField.backgroundColor = UIColor.white
//    let yOnScreen = textField.frame.origin.y
//    let textFieldHeight = textField.frame.height
//    let heightToGoDown = view.frame.size.height-yOnScreen-textFieldHeight-20
//    animateTextField(textField: textField, up: false, height: heightToGoDown)
////  }

 }
