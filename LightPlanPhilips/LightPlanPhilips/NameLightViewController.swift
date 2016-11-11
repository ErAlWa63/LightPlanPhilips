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


import UIKit

class NameLightViewController : UIViewController {
  let d = D() // debugger functionality
  
  @IBOutlet weak var dropLightType: UIPickerView!
  @IBOutlet weak var nameLightType: UITextField!
  @IBOutlet weak var removeButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func removeButton(_ sender: Any) {
    if let delegateLamp = delegateLamp {
      delegateLamp.nameLight = nil
    }
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveButton(_ sender: Any) {
    if let delegateLamp = delegateLamp {
      if let temporaryNameLight = temporaryNameLight {
        delegateLamp.nameLight = temporaryNameLight
      }
    }
    dismiss(animated: true, completion: nil)
  }
  
  var delegateLamp      : Lamp!
  var temporaryNameLight: NameLight!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dropLightType.dataSource         = self
    dropLightType.delegate           = self
    dropLightType.layer.borderColor  = UIColor.lightGray.cgColor
    dropLightType.layer.borderWidth  = 0.5
    dropLightType.layer.cornerRadius = 5
    if let delegateLamp = delegateLamp {
      if let nameLight = delegateLamp.nameLight {
        temporaryNameLight = NameLight(name: nameLight.name, lightTypeIndex: nameLight.lightTypeIndex)
      } else {
        removeButton.isHidden = true
        saveButton.isHidden = true
        temporaryNameLight = NameLight(name: "!\(delegateLamp.name)", lightTypeIndex: 0)
      }
      if let temporaryNameLight = temporaryNameLight {
        nameLightType.text = temporaryNameLight.name
        dropLightType.selectRow((temporaryNameLight.lightTypeIndex), inComponent: 0, animated: true)
      }
    }
    nameLightType.keyboardType = UIKeyboardType.alphabet
    nameLightType.delegate     = self
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
    tapRecognizer.numberOfTapsRequired = 1
    self.view.addGestureRecognizer(tapRecognizer)
  }
  
  func handleSingleTap(recognizer: UITapGestureRecognizer) {
    self.view.endEditing(true)
  }
}

extension NameLightViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return DataLightPlan.sharedInstance.listLightType.count
  }
}

extension NameLightViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if let temporaryNameLight = temporaryNameLight {
      saveButton.isHidden = false
      temporaryNameLight.lightTypeIndex = row
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 30
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    pickerView.endEditing(true)
    return DataLightPlan.sharedInstance.listLightType[row].name
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let myImageView   = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    myImageView.image = DataLightPlan.sharedInstance.listLightType[row].pictogram
    let rowString     = DataLightPlan.sharedInstance.listLightType[row].name
    let myLabel       = UILabel(frame: CGRect(x: 40, y: 0, width: pickerView.bounds.width - 70, height: 25))
    myLabel.font      = UIFont(name: "Apple SD Gothic Neo Regular", size: 23.0)
    myLabel.text      = rowString
    let myView        = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 25))
    myView.addSubview(myLabel)
    myView.addSubview(myImageView)
    return myView
  }
}

extension NameLightViewController: UITextFieldDelegate {
  public func textFieldDidEndEditing(_ textField: UITextField) {
    if let nameLightType = nameLightType {
      saveButton.isHidden = false
      if let text = nameLightType.text {
        temporaryNameLight.name = text
      } else {
        temporaryNameLight.name = ""
      }
    }
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return true
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameLightType.resignFirstResponder()
    return true
  }
}
