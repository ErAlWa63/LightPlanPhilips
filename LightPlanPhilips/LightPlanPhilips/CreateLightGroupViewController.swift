//
//  CreateLightGroupViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 17/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// https://makeapppie.com/2016/10/10/using-tableviews-in-subviews/
//
// http://blog.evizija.si/ios-swift-custom-horizontal-collection-view-with-images/

import UIKit

class CreateLightGroupViewController: UIViewController {
  let debug = Debug() // debugger functionality
  fileprivate let reuseIdentifier = "lightTypeCell"
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  //    var selectedCell: Int! = 0
  
  //  var delegateLightGroupTypeIndex: Int?
  //  var closureToPerform: ((Int) -> Void)?
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var nameLightGroup: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name:NSNotification.Name.UIKeyboardWasShown, object: nil);
    nameLightGroup.delegate = self
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    self.collectionView!.allowsMultipleSelection = false
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
    tapRecognizer.numberOfTapsRequired = 1
    self.view.addGestureRecognizer(tapRecognizer)
  }
  
  func handleSingleTap(recognizer: UITapGestureRecognizer) {
    self.view.endEditing(true)
  }
  
//  func keyboardWasShown(notification: NSNotification) {
//    let info = notification.userInfo!
//    let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//    
//    UIView.animateWithDuration(0.1, animations: { () -> Void in
//      self.bottomConstraint.constant = keyboardFrame.size.height + 20
//    })
//  }
}

extension CreateLightGroupViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    return DataLightPlan.sharedInstance.listLamp.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath)
    let myImageView   = UIImageView(frame: CGRect(x: 5, y: 10, width: 15, height: 15))
    myImageView.image = DataLightPlan.sharedInstance.listLamp[indexPath.item].pictogram
    let myLabel       = UILabel(frame: CGRect(x: 25, y: 10, width: cell.frame.width - 40, height: 15))
    myLabel.font      = UIFont(name: "AppleSDGothicNeo-Light", size: 23.0)
    myLabel.text      = DataLightPlan.sharedInstance.listLamp[indexPath.item].name
    myLabel.textAlignment = .left
    cell.backgroundColor = UIColor.white
    cell.addSubview(myLabel)
    cell.addSubview(myImageView)
    
    
    //    cell.label.text = stringArray[indexPath.item]
    //
    //    cell.layer.shouldRasterize = true;
    //    cell.layer.rasterizationScale = UIScreen.mainScreen().scale
    //
    //    if(selectedCell != nil){
    //      if(indexPath.item == selectedCell){
    //        cell.image.image = UIImage(named: "FullCircle")!
    //        cell.label.textColor = UIColor.whiteColor()
    //      }
    //      else{
    //        cell.image.image = UIImage(named: "EmptyCircle")!
    //        cell.label.textColor = UIColor.blackColor()
    //      }
    //    }
    
    return cell
  }
  
}

extension CreateLightGroupViewController : UICollectionViewDelegate {
  
}
extension CreateLightGroupViewController: UITextFieldDelegate {
  public func textFieldDidEndEditing(_ textField: UITextField) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    //    if delegateLamp != nil {
    //      if let nameLightType = nameLightType {
    //        saveButton.isHidden = false
    //        if let text = nameLightType.text {
    //          if let temporaryNameLight = temporaryNameLight {
    //            temporaryNameLight.name = text
    //          }
    //        }
    //      }
    //    }
    animateTextField(textField: textField, up: false, height: view.frame.size.height - textField.frame.origin.y - textField.frame.height - 20)
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //    if (delegateLamp) != nil {
    //      return true
    //    } else {
    //      return false
    //    }
    return true
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameLightGroup.resignFirstResponder()
    return true
  }
  
  func animateTextField(textField: UITextField, up: Bool, height: CGFloat) {
    UIView.beginAnimations("animateTextField", context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(0.3)
    self.view.frame = self.view.frame.offsetBy(dx: 0, dy: (up ? height - 250 : 250 - height))
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

