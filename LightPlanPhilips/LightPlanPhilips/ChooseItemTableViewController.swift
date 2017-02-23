//
//  chooseTableViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 01-12-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

//class ChooseItemTableViewController: UITableViewController {


class ChooseItemTableViewController: UITableViewController {
  

  var area: Bool = false
  var chooseList: [ChooseItem] = []
  var itemName: String = ""
  var itemImage: UIImage!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0)

    // check if area
    if area {
      // get list of areas
      chooseList = DataSource.sharedInstance.getGroupAreas()
    } else {
      // get list of types
      chooseList = DataSource.sharedInstance.getGroupTypes()
    }
  }
  
  // required functions for table view
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.chooseList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ChooseItemCell
    cell.itemName.text = chooseList[indexPath.row].itemName
    cell.itemImage.image = chooseList[indexPath.row].itemImage
    return cell
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UITableViewCell
    let indexPath = self.tableView.indexPath(for: cell)
    
    itemName = chooseList[(indexPath?.row)!].itemName
    
    itemImage = chooseList[(indexPath?.row)!].itemImage
  }
  

}
