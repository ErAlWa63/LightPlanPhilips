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
  var listRoomType = [
    RoomType(name: "bathroom",   file: "bathroom.png", description: ""),
    RoomType(name: "bedroom",    file: "bedroom.png", description: ""),
    RoomType(name: "dining",     file: "dining.png", description: ""),
    RoomType(name: "kitchen",    file: "kitchen.png", description: ""),
    RoomType(name: "living",     file: "living.png", description: ""),
    RoomType(name: "toilet",     file: "toilet.png", description: ""),
    RoomType(name: "open space", file: "Open space.png", description: "Definable areas")]
  
}

extension SelectRoomTypeViewController: UICollectionViewDataSource {
  internal func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listRoomType.count
  }
  
  internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
  }
}

extension SelectRoomTypeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    nextButton.isHidden = false
    let selectedCell = collectionView.cellForItem(at: indexPath)!
    selectedCell.layer.borderColor  = UIColor.lightGray.cgColor
    selectedCell.layer.borderWidth  = 0.5
    selectedCell.layer.cornerRadius = 5
    selectedCell.tintColor          = UIColor.black
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let selectedCell = collectionView.cellForItem(at: indexPath)!
    selectedCell.layer.borderColor  = UIColor.clear.cgColor
    selectedCell.tintColor          = UIColor.clear
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      let cell = cell as! SelectRoomTypeCollectionCell
      cell.nameCell.text = listRoomType[indexPath.item].name
      cell.descriptionCell.text = listRoomType[indexPath.item].description
      cell.pictogramCell.image = listRoomType[indexPath.item].pictogram
  }
}
extension UIButton {
  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let relativeFrame = self.bounds
    let hitTestEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5)
    let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
    return hitFrame.contains(point)
  }
}
