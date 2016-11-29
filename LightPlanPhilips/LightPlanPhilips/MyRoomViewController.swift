//
//  MyRoomViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 28/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class MyRoomViewController: UIViewController {
  var destinationMyHome : Home?
  var closureToPerform: ((Home) -> Void)?

  @IBOutlet weak var backButton: UIButton!
  @IBAction func backButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  @IBOutlet weak var cancelButton: UIButton!
  @IBAction func cancelButton(_ sender: Any) {
    self.presentingViewController!.dismiss(animated: true, completion: nil)
  }
  @IBOutlet weak var myRoomTableView: UITableView!
  
  @IBAction private func nextButton(_ sender: Any) {
  }
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cancelButton.layer.cornerRadius = cancelButton.frame.size.width / 2
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
