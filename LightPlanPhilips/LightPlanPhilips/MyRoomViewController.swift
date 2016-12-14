import UIKit

class MyRoomViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  
  @IBOutlet weak var nextButton: UIButton!
  @IBAction func nextButton(_ sender: Any) {
  }
  @IBAction func addButton(_ sender: Any) {
    if let myHome = myHome {
      var nameRoom : String = ""
      let alertGiveRoom = UIAlertController(title: "Create new room", message: "Enter name", preferredStyle: .alert)
      alertGiveRoom.addTextField { (textField) in
        textField.text = ""
      }
      alertGiveRoom.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alertGiveRoom] (_) in
        if let alertGiveRoom = alertGiveRoom {
          if let textFields = alertGiveRoom.textFields {
            nameRoom = textFields[0].text!
            myHome.rooms.insert(Room(id: UUID().uuidString, name: nameRoom), at: 0)
            self.performSegue(withIdentifier: "SelectRoomTypeSegue", sender: nil)
          }
        }
        alertGiveRoom?.dismiss(animated: true, completion: nil)
      }))
      self.present(alertGiveRoom, animated: true, completion: nil)
    }
  }
  @IBAction func editButton(_ sender: Any) {
    let editButton = sender as! UIButton
    if myRoomTableView.isEditing{
      activateEditingEnvironment( editingButton: editButton, title: "Edit", editing: false, animated: false)
      nextButton.isHidden = false
    }
    else{
      activateEditingEnvironment( editingButton: editButton, title: "Done", editing: true, animated: true)
      nextButton.isHidden = true
    }
  }
  @IBOutlet weak var addButton: UIButton!
  
  private func activateEditingEnvironment( editingButton: UIButton, title: String, editing: Bool, animated: Bool) {
    myRoomTableView.setEditing(editing, animated: animated);
    editingButton.setTitle(title, for: .normal)
  }
  
  @IBOutlet weak var myRoomTableView: UITableView!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    passInformationToNextScene(segue: segue)
  }
  
  private func passInformationToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "SelectRoomTypeSegue" {
      passInformationToSomewhereScene(segue: segue)
    }
  }
  
  private func passInformationToSomewhereScene(segue: UIStoryboardSegue) {
    if let destination = segue.destination as? SelectRoomTypeViewController {
      passDataToScene( destination: destination)
      passClosureToScene( destination: destination)
    }
  }
  
  private func passDataToScene (destination: SelectRoomTypeViewController) {
    if let myHome = myHome {
      destination.myHome = myHome
    }
  }
  
  private func passClosureToScene ( destination: SelectRoomTypeViewController) {
    destination.closureToPerform = { [weak self] (myHome: Home) in
      if let strongSelf = self {
        strongSelf.myHome = myHome
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    myRoomTableView.reloadData()
    self.navigationController?.navigationBar.isHidden = true
    myHome = DataSource.sharedInstance.myHome
    if myHome?.rooms.count == 0 {
      nextButton.isHidden = true
    } else {
      nextButton.isHidden = false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    DataSource.sharedInstance.createData()
    myHome = DataSource.sharedInstance.myHome
    myRoomTableView.delegate = self
    myRoomTableView.dataSource = self
    myRoomTableView.reloadData()
    self.navigationController?.navigationBar.isHidden = true
    addButton.layer.cornerRadius = 0.5 * addButton.bounds.size.width
    addButton.layer.borderWidth = 1.0
    addButton.layer.borderColor = UIColor.black.cgColor
    if myHome?.rooms.count == 0 {
      nextButton.isHidden = true
    } else {
      nextButton.isHidden = false
    }
  }
}

extension MyRoomViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "myRoomCell", for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let myHome = myHome {
      return myHome.rooms.count
    } else {
      return 0
    }
  }
}

extension MyRoomViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.delete) {
      if let myHome = myHome {
        myHome.rooms.remove(at: indexPath.row)
        tableView.reloadData()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let selectedCell = tableView.cellForRow(at: indexPath) {
      selectedCell.layer.borderColor  = UIColor.clear.cgColor
      selectedCell.tintColor          = UIColor.clear
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let selectedCell = tableView.cellForRow(at: indexPath) {
      selectedCell.layer.borderColor  = UIColor.lightGray.cgColor
      selectedCell.layer.borderWidth  = 0.5
      selectedCell.layer.cornerRadius = 5
      selectedCell.tintColor          = UIColor.black
      myHome?.selectedRoom = indexPath.row
    }
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    if let myHome = myHome {
      if (self.isEditing == false && indexPath.row == 0) {
        return .none
      }
      if (self.isEditing && indexPath.row == myHome.rooms.count){
        return .insert
      }
      else{
        return .delete
      }
    } else {
      return .none
    }
  }
  
  func moveRoomAtIndex( rooms: [Room], fromIndex: Int, toIndex: Int ) -> [Room] {
    var localRooms = rooms
    if fromIndex == toIndex {
      return localRooms
    }
    let movedRoom = localRooms[fromIndex]
    localRooms.remove(at: fromIndex)
    localRooms.insert(movedRoom, at: toIndex)
    return localRooms
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if let myHome = myHome {
      myHome.rooms = moveRoomAtIndex(rooms: myHome.rooms, fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let myHome = myHome {
      let cell = cell as! MyRoomTableViewCell
      cell.nameCell.text = myHome.rooms[indexPath.item].name
      cell.descriptionCell.text = myHome.rooms[indexPath.item].description
      cell.pictogramCell.image = myHome.rooms[indexPath.item].pictogram
    }
  }
}
