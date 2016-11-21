//
//  LightTypeCollectionViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 11/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// https://www.raywenderlich.com/136159/uicollectionview-tutorial-getting-started
//
// https://www.appcoda.com/ios-collection-view-tutorial/

import UIKit

final class LightTypeCollectionViewController: UICollectionViewController {
  var delegateLightTypeIndex: Int?
  var closureToPerform: ((Int) -> Void)?
  fileprivate let reuseIdentifier = "lightTypeCell"
  fileprivate let sectionInsets = UIEdgeInsets(top: 18.0, left: 10.0, bottom: 18.0, right: 10.0)
  fileprivate let itemsPerRow: CGFloat = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    self.collectionView!.allowsMultipleSelection = false
    self.collectionView!.backgroundColor = UIColor.lightGray
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    let myImageView   = UIImageView(frame: CGRect(x: (cell.frame.width / 2) - 10, y: 5, width: 20, height: 20))
    myImageView.image = DataLightPlan.sharedInstance.listLightType[indexPath.item].pictogram
    let myLabel       = UILabel(frame: CGRect(x: 5, y: 30, width: cell.frame.width - 10, height: 20))
    myLabel.font      = UIFont(name: "Apple SD Gothic Neo Regular", size: 23.0)
    myLabel.text      = DataLightPlan.sharedInstance.listLightType[indexPath.item].name

    myLabel.textAlignment = .center
    cell.backgroundColor = UIColor.white
    cell.addSubview(myLabel)
    cell.addSubview(myImageView)
    if let delegateLightTypeIndex = delegateLightTypeIndex {
      if indexPath.row == delegateLightTypeIndex {
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColorFromRGB(rgbValue: 0xD21D0E).cgColor
      }
    }
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  DataLightPlan.sharedInstance.listLightType.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegateLightTypeIndex = indexPath.row
    closureToPerform?( indexPath.row)
    dismiss(animated: true, completion: nil)
  }
  
  override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    if delegateLightTypeIndex != nil {
      if let cell = collectionView.cellForItem(at: indexPath as IndexPath) {
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColorFromRGB(rgbValue: 0xE98300).cgColor
      }
    }
    return true
  }
  
  func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}

extension LightTypeCollectionViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthPerItem = (view.frame.width - sectionInsets.left * (itemsPerRow + 1)) / itemsPerRow
    return CGSize(width: widthPerItem, height: 50)
  }
}
