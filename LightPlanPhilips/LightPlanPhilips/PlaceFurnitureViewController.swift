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
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var scene: PlaceFurnitureScene?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.reloadData()
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
    LightType(name: "br30 slim",               file: "br30_slim.png"),
    LightType(name: "ceiling",                 file: "ceiling.png"),
    LightType(name: "floor",                   file: "floor.png"),
    LightType(name: "go",                      file: "go.png"),
    LightType(name: "gu10 perfectfit",         file: "gu10_perfectfit.png"),
    LightType(name: "lichtstrip",              file: "lightstrip.png"),
    LightType(name: "pendant",                 file: "pendant.png"),
    LightType(name: "rec spot",                file: "rec_spot.png"),
    LightType(name: "spot",                    file: "spot.png"),
    LightType(name: "table",                   file: "table.png"),
    LightType(name: "white and color e27 b22", file: "white_and_color_e27_b22.png")]
}

extension PlaceFurnitureViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listFurniture.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeFurnitureCell", for: indexPath) as! PlaceFurnitureCollectionCell
    cell.nameCell.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18.0)
    cell.nameCell.text = listFurniture[indexPath.row].name
    cell.pictogramCell.image = listFurniture[indexPath.row].pictogram
    return cell
  }
}

extension PlaceFurnitureViewController: UICollectionViewDelegate {
}
