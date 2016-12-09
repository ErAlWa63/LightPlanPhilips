import UIKit

class SelectRoomTypeViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  
  @IBAction func backButton(_ sender: Any) {
    _ = navigationController?.popViewController(animated: true)
  }
  @IBAction func cancelButton(_ sender: Any) {
    _ = navigationController?.popToRootViewController(animated: true)
  }
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var collectionview: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionview.reloadData()
    nextButton.isHidden = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    passInformationToNextScene(segue: segue)
  }
  
  private func passInformationToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "RoomShapeSegue" {
      passInformationToSomewhereScene(segue: segue)
    }
  }
  
  private func passInformationToSomewhereScene(segue: UIStoryboardSegue) {
    if let destination = segue.destination as? RoomShapeViewController {
      passDataToScene( destination: destination)
      passClosureToScene( destination: destination)
    }
  }
  
  private func passDataToScene (destination: RoomShapeViewController) {
    if let myHome = myHome {
      destination.myHome = myHome
    }
  }
  
  private func passClosureToScene ( destination: RoomShapeViewController) {
    destination.closureToPerform = { [weak self] (myHome: Home) in
      if let strongSelf = self {
        strongSelf.myHome = myHome
      }
    }
  }
}

extension SelectRoomTypeViewController: UICollectionViewDataSource {
  internal func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let myHome = myHome {
      return myHome.rooms.count
    } else {
      return 0
    }
  }
  
  internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SelectRoomTypeCollectionViewCell
    if let myHome = myHome {
      cell.nameCell.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18.0)
      cell.nameCell.text = myHome.rooms[indexPath.item].name
      cell.descriptionCell.font = UIFont(name: "AppleSDGothicNeo-Light", size: 10.0)
      cell.descriptionCell.text = myHome.rooms[indexPath.item].description
      cell.pictogramCell.image = myHome.rooms[indexPath.item].pictogram
    }
    return cell
  }
}

extension SelectRoomTypeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    
    return true
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let myHome = myHome {
      myHome.selectedRoom = indexPath.row
      nextButton.isHidden = false
      let selectedCell = collectionView.cellForItem(at: indexPath)!
      selectedCell.layer.borderColor  = UIColor.lightGray.cgColor
      selectedCell.layer.borderWidth  = 0.5
      selectedCell.layer.cornerRadius = 5
      selectedCell.tintColor          = UIColor.black
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let selectedCell = collectionView.cellForItem(at: indexPath)!
    selectedCell.layer.borderColor  = UIColor.clear.cgColor
    selectedCell.tintColor          = UIColor.clear
  }
}
