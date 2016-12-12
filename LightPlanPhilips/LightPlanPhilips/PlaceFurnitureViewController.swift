import UIKit
import SpriteKit

class PlaceFurnitureViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  let debug = Debug() // debugger functionality
  
  
  @IBAction func backButton(_ sender: Any) {
    _ = navigationController?.popViewController(animated: true)
  }
  @IBAction func cancelButton(_ sender: Any) {
    _ = navigationController?.popToRootViewController(animated: true)
  }
  @IBAction func nextButton(_ sender: Any) {
  }
  
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var scene: PlaceFurnitureScene?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.reloadData()
    nextButton.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let view = self.view as! SKView? {
      scene = SKScene(fileNamed: "PlaceFurnitureScene") as? PlaceFurnitureScene
      if let scene = scene {
        scene.myHome = myHome
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = false
        view.showsNodeCount = false
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    passInformationToNextScene(segue: segue)
  }
  
  private func passInformationToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "PlaceBulbSegue" {
      passInformationToSomewhereScene(segue: segue)
    }
  }
  
  private func passInformationToSomewhereScene(segue: UIStoryboardSegue) {
    if let destination = segue.destination as? PlaceBulbViewController {
      passDataToScene( destination: destination)
      passClosureToScene( destination: destination)
    }
  }
  
  private func passDataToScene (destination: PlaceBulbViewController) {
    if let myHome = myHome {
      destination.myHome = myHome
    }
  }
  
  private func passClosureToScene ( destination: PlaceBulbViewController) {
    destination.closureToPerform = { [weak self] (myHome: Home) in
      if let strongSelf = self {
        strongSelf.myHome = myHome
      }
    }
  }
  var listFurniture = [
    Furniture(name: "flatscreen", file: "flatscreen_furniture.png"),
    Furniture(name: "seat",       file: "seat_furniture.png"),
    Furniture(name: "sofa",       file: "sofa_furniture.png"),
    Furniture(name: "sofa b",     file: "sofa_b_furniture.png"),
    Furniture(name: "table",      file: "table_furniture.png")]
}

extension PlaceFurnitureViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listFurniture.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: "placeFurnitureCell", for: indexPath)
  }
}

extension PlaceFurnitureViewController: UICollectionViewDelegate {
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
    let cell = cell as! PlaceFurnitureCollectionCell
    cell.nameCell.text = listFurniture[indexPath.row].name
    cell.pictogramCell.image = listFurniture[indexPath.row].pictogram
  }
}
