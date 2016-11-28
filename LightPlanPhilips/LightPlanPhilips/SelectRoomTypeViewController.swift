//
//  SelectRoomTypeViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 22/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class SelectRoomTypeViewController: UIViewController {
  internal let debug = Debug() // debugger functionality
  
  var delegateRoom : [Room]? = nil
  var closureToPerform : (([Room]) -> Void)?
  
  @IBAction private func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func nextButton(_ sender: Any) {
  }
  
  @IBOutlet private weak var nextButton: UIButton!
  
  @IBOutlet weak var collectionview: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if var delegateRoom = delegateRoom {
      debug.console(message: "delegateRoom = \(delegateRoom)", file: #file, function: #function, line: #line)
//      for index in 0 ..< delegateRoom.count {
//        delegateRoom[index].selected = false
//      }
    }
    self.collectionview.reloadData()
    
    //    nextButton.isHidden = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
}

extension SelectRoomTypeViewController: UICollectionViewDataSource {
  internal func numberOfSections(in collectionView: UICollectionView) -> Int {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    return 1
  }
  
  internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if let delegateRoom = delegateRoom {
      return delegateRoom.count
    } else {
      return 0
    }
  }
  
  internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
    if let delegateRoom = delegateRoom {
      let selected                 = UILabel(frame: CGRect(x: 2, y: 0, width: 20, height: 20))
      selected.font                = UIFont(name: "AppleSDGothicNeo-Bold", size: 30.0)
      selected.textColor           = UIColor.blue
      //selected.text                = delegateRoom[indexPath.row].selected ? "✓" : ""
      cell.addSubview(selected)
      let pictogram                = UIImageView(frame: CGRect(x: 42, y: 2, width: 20, height: 20))
      pictogram.image              = delegateRoom[indexPath.row].pictogram
      cell.addSubview(pictogram)
      let name                     = UILabel(frame: CGRect(x: 72, y: 0, width: cell.frame.width - 46, height: 20))
      name.font                    = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
      name.text                    = delegateRoom[indexPath.row].name
      cell.addSubview(name)
      let description              = UILabel(frame: CGRect(x: 72, y: 14, width: cell.frame.width - 46, height: 20))
      description.font             = UIFont(name: "AppleSDGothicNeo-Light", size: 10.0)
      description.text             = delegateRoom[indexPath.row].description
      cell.addSubview(description)
    }
    return cell
  }
}

extension SelectRoomTypeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    debug.console(message: "start", file: #file, function: #function, line: #line)
return true
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if var delegateRoom = delegateRoom {
      debug.console(message: "start", file: #file, function: #function, line: #line)
//      debug.console(message: "delegateRoom[indexPath.row].selected = \(delegateRoom[indexPath.row].selected)", file: #file, function: #function, line: #line)
//      delegateRoom[indexPath.row].selected = !delegateRoom[indexPath.row].selected
//      debug.console(message: "delegateRoom[indexPath.row].selected = \(delegateRoom[indexPath.row].selected)", file: #file, function: #function, line: #line)

    }
  }
}
