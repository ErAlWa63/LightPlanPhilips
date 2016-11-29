//
//  MyRoomViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 28/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class MyRoomViewController: UIViewController {
  let debug = Debug()
  @IBOutlet weak var myRoomTableView: UITableView!
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func nextButton(_ sender: Any) {
  }
  @IBOutlet weak var nextButton: UIButton!
  
  var destinationMyHome : Home?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    myRoomTableView.delegate = self
    myRoomTableView.dataSource = self
    myRoomTableView.layer.cornerRadius = 5
    myRoomTableView.layer.borderWidth = 2.0
    myRoomTableView.layer.borderColor = UIColor.black.cgColor
    myRoomTableView.reloadData()
  }
}

extension MyRoomViewController: UITableViewDelegate {
  
}

extension MyRoomViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let destinationMyHome = destinationMyHome {
      debug.console(message: "destinationMyHome.rooms.count = \(destinationMyHome.rooms.count)", file: #file, function: #function, line: #line)
      return destinationMyHome.rooms.count <= 5 ? destinationMyHome.rooms.count : 5
    } else {
      return 5
    }
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myRoomCell", for: indexPath)
    if let myHome = destinationMyHome {
      let myLabel       = UILabel(frame: CGRect(x: 2, y: 10, width: cell.frame.width - 4, height: 20))
      myLabel.font      = UIFont(name: "AppleSDGothicNeo-Light", size: 23.0)
      myLabel.text      = myHome.rooms[indexPath.item].name
      cell.addSubview(myLabel)
      
//      myLabel.textAlignment = .center
//      cell.backgroundColor = UIColor.white
      //    let myImageView   = UIImageView(frame: CGRect(x: (cell.frame.width / 2) - 10, y: 5, width: 20, height: 20))
      //    myImageView.image = DataLightPlan.sharedInstance.listLightType[indexPath.item].pictogram
      //    cell.addSubview(myImageView)
      //    if let delegateLightTypeIndex = delegateLightTypeIndex {
      //      if indexPath.row == delegateLightTypeIndex {
      //        cell.layer.cornerRadius = 5
      //        cell.layer.borderWidth = 2.0
      //        cell.layer.borderColor = UIColorFromRGB(rgbValue: 0xD21D0E).cgColor
      //      }
      //    }
      
    }
    return cell
  }
}
