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

var stringArray: [String] = ["1", "2", "3", "4","5", "6", "7", "8",
                             "9", "10", "11"]

class CreateLightGroupViewController: UIViewController {
  @IBOutlet weak var createLightGroupBulbCollectionView: UICollectionView!
  
  var selectedCell: Int! = 0

//  var delegateLightGroupTypeIndex: Int?
//  var closureToPerform: ((Int) -> Void)?

  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
 }
//  @IBOutlet weak var createLightGroupBulbCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//    self.collectionView!.allowsMultipleSelection = false
//    self.collectionView!.backgroundColor = UIColor.lightGray
    
    // Do any additional setup after loading the view.
    selectedCell = 0

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

//: UICollectionViewDataSource
extension CreateLightGroupBulbCollectionView {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return stringArray.count
  }
  
  func collectionView(collectionView: UICollectionView,
                      cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath)
    let myLabel       = UILabel(frame: CGRect(x: 5, y: 30, width: cell.frame.width - 10, height: 20))
    myLabel.font      = UIFont(name: "Apple SD Gothic Neo Regular", size: 23.0)
    myLabel.text      = stringArray[indexPath.item]
    myLabel.textAlignment = .center
    cell.backgroundColor = UIColor.white
    cell.addSubview(myLabel)

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
