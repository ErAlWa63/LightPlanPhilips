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
// http://stackoverflow.com/questions/26089152/sending-data-with-segue-with-swift
//


import UIKit

class NameLightViewController : UIViewController {
//    var selectedRow 
    @IBOutlet weak var dropLightType: UIPickerView!
    @IBOutlet weak var nameLightType: UITextField!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
//        let nameLight = NameLight(name: nameLightType.text, lightType: dropLightType.selectedRow(inComponent: <#T##Int#>))
    }
    
    var delegateLampRow: Int!
    
//    let saveBut : PhilipUIButton(name: "Remove", color: red, )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropLightType.dataSource         = self
        dropLightType.delegate           = self
        dropLightType.layer.borderColor  = UIColor.lightGray.cgColor
        dropLightType.layer.borderWidth  = 0.5
        dropLightType.layer.cornerRadius = 5
        
//        if DataLightPlan.sharedInstance.listLamp[delegateLampRow].nameLight == nil {
//            nameLightType.text = ""
//        } else {
//            nameLightType.text = DataLightPlan.sharedInstance.listLamp[delegateLampRow].nameLight?.name
//        }
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
//        self.textBox.text = DataLightPlan.sharedInstance.listLightType[row].name
//        dropLightType.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerView.endEditing(true)
        return DataLightPlan.sharedInstance.listLightType[row].name
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
//        if textField == self.textBox {
//            dropLightType.isHidden = false
//            textField.endEditing(true)
//        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myImageView   = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
//        myImageView.backgroundColor = UIColor.lightGray
        myImageView.image = DataLightPlan.sharedInstance.listLightType[row].pictogram
        let rowString     = DataLightPlan.sharedInstance.listLightType[row].name
        let myLabel       = UILabel(frame: CGRect(x: 40, y: 0, width: pickerView.bounds.width - 70, height: 25))
        myLabel.font      = UIFont(name: "Apple SD Gothic Neo Regular", size: 23.0)
        myLabel.text      = rowString
//        myLabel.backgroundColor = UIColor.lightGray
        let myView        = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 25))
        myView.addSubview(myLabel)
        myView.addSubview(myImageView)
        return myView
    }
}

extension NameLightViewController: UITextViewDelegate {
//    public protocol UITextViewDelegate : NSObjectProtocol, UIScrollViewDelegate {
//        
//        
//        @available(iOS 2.0, *)
//        optional public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
//        
//        @available(iOS 2.0, *)
//        optional public func textViewShouldEndEditing(_ textView: UITextView) -> Bool
//        
//        
//        @available(iOS 2.0, *)
//        optional public func textViewDidBeginEditing(_ textView: UITextView)
//        
//        @available(iOS 2.0, *)
//        optional public func textViewDidEndEditing(_ textView: UITextView)
//        
//        
//        @available(iOS 2.0, *)
//        optional public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
//        
//        @available(iOS 2.0, *)
//        optional public func textViewDidChange(_ textView: UITextView)
//        
//        
//        @available(iOS 2.0, *)
//        optional public func textViewDidChangeSelection(_ textView: UITextView)
//        
//        
//        @available(iOS 10.0, *)
//        optional public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
//        
//        @available(iOS 10.0, *)
//        optional public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
//        
//        
//        @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead")
//        optional public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool
//        
//        @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead")
//        optional public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool
//    }

    
}
