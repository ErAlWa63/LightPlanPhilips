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
  let d = D() // debugger functionality
  var closureToPerform: ((Int) -> Void)?
  fileprivate let reuseIdentifier = "lightTypeCell"
  fileprivate let sectionInsets = UIEdgeInsets(top: 18.0, left: 10.0, bottom: 18.0, right: 10.0)
  fileprivate let itemsPerRow: CGFloat = 3
  
  override func viewDidLoad() {
    super.viewDidLoad()
    d.c(m: "start", f: #file, fu: #function, l: #line)
   
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    let myImageView   = UIImageView(frame: CGRect(x: (cell.frame.width / 2) - 10, y: 5, width: 20, height: 20))
    myImageView.image = DataLightPlan.sharedInstance.listLightType[indexPath.item].pictogram
    let rowString     = DataLightPlan.sharedInstance.listLightType[indexPath.item].name
    let myLabel       = UILabel(frame: CGRect(x: 5, y: 30, width: cell.frame.width - 10, height: 25))
    myLabel.font      = UIFont(name: "Apple SD Gothic Neo Regular", size: 23.0)
    myLabel.text      = rowString
    cell.addSubview(myLabel)
    cell.addSubview(myImageView)
    cell.backgroundColor = UIColor.green
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  DataLightPlan.sharedInstance.listLightType.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    addToList.append(objectsArray[indexPath.row])
    d.c(m: "start", f: #file, fu: #function, l: #line)
    d.c(m: "indexPath.row = \(indexPath.row)", f: #file, fu: #function, l: #line)
    let cell = collectionView.cellForItem(at: indexPath as IndexPath)
    cell?.layer.borderWidth = 2.0
    cell?.layer.borderColor = UIColor.gray.cgColor
    closureToPerform?( indexPath.row)
    d.c(m: "stop", f: #file, fu: #function, l: #line)
    dismiss(animated: true, completion: nil)
  }
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   */
  
  override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//    dismiss(animated: true, completion: nil)
  }
}

//extension LightTypeCollectionViewController: UICollectionViewDataSource {
//
//}

extension LightTypeCollectionViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthPerItem = (view.frame.width - sectionInsets.left * (itemsPerRow + 1)) / itemsPerRow
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  //  @available(iOS 6.0, *)
  //  optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
  //
  //  @available(iOS 6.0, *)
  //  optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
  //
  //  @available(iOS 6.0, *)
  //  optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
  //
}
