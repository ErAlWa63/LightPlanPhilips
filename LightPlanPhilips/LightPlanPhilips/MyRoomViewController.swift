import UIKit

class MyRoomViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  
  @IBAction func backButton(_ sender: Any) {
    _ = navigationController?.popViewController(animated: true)
  }
  @IBAction func cancelButton(_ sender: Any) {
    _ = navigationController?.popToRootViewController(animated: true)
  }
  @IBAction func addButton(_ sender: Any) {
    if let myHome = myHome {
      myHome.rooms.insert(Room(id: UUID().uuidString, name: "Fantasy Room", file: "living.png"), at: 0)
      myRoomTableView.reloadData()
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
  
  private func activateEditingEnvironment( editingButton: UIButton, title: String, editing: Bool, animated: Bool) {
    myRoomTableView.setEditing(editing, animated: animated);
    editingButton.setTitle(title, for: .normal)
  }
  
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var myRoomTableView: UITableView!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    passInformationToNextScene(segue: segue)
  }
  
  private func passInformationToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "SelectRoomtypeSegue" {
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    DataSource.sharedInstance.createData()
    myHome = DataSource.sharedInstance.myHome
    myRoomTableView.delegate = self
    myRoomTableView.dataSource = self
    myRoomTableView.reloadData()
    self.navigationController?.navigationBar.isHidden = true
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
