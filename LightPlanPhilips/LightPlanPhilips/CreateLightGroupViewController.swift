//
//  CreateLightGroupViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 17/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// https://makeapppie.com/2016/10/10/using-tableviews-in-subviews/

import UIKit

class CreateLightGroupViewController: UIViewController {
  var delegateLightGroupTypeIndex: Int?
  var closureToPerform: ((Int) -> Void)?
  fileprivate let reuseIdentifier = "lightGroupTypeCell"
  fileprivate let sectionInsets = UIEdgeInsets(top: 18.0, left: 10.0, bottom: 18.0, right: 10.0)
  fileprivate let itemsPerRow: CGFloat = 2

  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
 }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//    self.collectionView!.allowsMultipleSelection = false
//    self.collectionView!.backgroundColor = UIColor.lightGray
    
    // Do any additional setup after loading the view.
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
