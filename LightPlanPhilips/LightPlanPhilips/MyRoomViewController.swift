//
//  MyRoomViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 28/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// https://www.natashatherobot.com/using-swift-extensions/
//

import UIKit

class MyRoomViewController: UIViewController {
  var destinationMyHome : Home?
  var closureToPerform: ((Home) -> Void)?
  internal let debug = Debug() // debugger functionality
  
  
  @IBOutlet weak var backButton: UIButton!
  @IBAction func backButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  @IBOutlet weak var cancelButton: UIButton!
  @IBAction func cancelButton(_ sender: Any) {
    self.presentingViewController!.dismiss(animated: true, completion: nil)
  }
  
  //  @IBAction func editButton(_ sender: Any) {
  //    let editButton = sender as! UIButton
  //    let erik = myRoomTableView.isEditing
  //    if myRoomTableView.isEditing {
  //      editButton.setTitle( "Edit", for: .normal)
  //      myRoomTableView.setEditing(!myRoomTableView.isEditing, animated: true)
  //      //      setEditButton( button: editButton, name: "Edit", setEditingState: false)
  //    } else {
  //      editButton.setTitle( "Done", for: .normal)
  //      myRoomTableView.setEditing(!myRoomTableView.isEditing, animated: true)
  //      //      setEditButton( button: editButton, name: "Done", setEditingState: false)
  //    }
  //  }
  //
  //  private func setEditButton( button: UIButton, name: String, setEditingState: Bool) {
  //    button.setTitle( name, for: .normal)
  //    setEditing(setEditingState, animated: true)
  //  }
  
  @IBAction func addButton(_ sender: Any) {
  }
  
  
  
  @IBOutlet weak var myRoomTableView: UITableView!
  
  @IBAction private func nextButton(_ sender: Any) {
  }
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    debug.console(message: "start", file: #file, function: #function, line: #line)

    cancelButton.layer.cornerRadius = cancelButton.frame.size.width / 2
    myRoomTableView.delegate = self
    myRoomTableView.dataSource = self
    
    myRoomTableView.layer.cornerRadius = 2
    myRoomTableView.layer.borderWidth = 1.0
    myRoomTableView.layer.borderColor = UIColor.black.cgColor
    myRoomTableView.reloadData()
  }
  
}

extension MyRoomViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    debug.console(message: "start", file: #file, function: #function, line: #line)

    if (editingStyle == UITableViewCellEditingStyle.delete) {
      if let myHome = destinationMyHome {
        myHome.rooms.remove(at: indexPath.row)
        tableView.reloadData()
        // handle delete (by removing the data from your array and updating the tableview)
      }
    }
  }
  
}

extension MyRoomViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    debug.console(message: "start", file: #file, function: #function, line: #line)

    if let destinationMyHome = destinationMyHome {
      return destinationMyHome.rooms.count
    } else {
      return 0
    }
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    debug.console(message: "start", file: #file, function: #function, line: #line)

    let cell = tableView.dequeueReusableCell(withIdentifier: "myRoomCell", for: indexPath) as! MyRoomTableViewCell
    if let myHome = destinationMyHome {
      cell.nameCell.text = myHome.rooms[indexPath.item].name
      cell.pictogramCell.image = myHome.rooms[indexPath.item].pictogram
    }
    return cell
  }
  
  
}
