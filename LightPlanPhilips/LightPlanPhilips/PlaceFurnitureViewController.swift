import UIKit
import SpriteKit

class PlaceFurnitureViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  
  let debug = Debug() // debugger functionality
  
  @IBOutlet weak var backButton: UIButton!
  @IBAction func backButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelButton(_ sender: Any) {
    self.presentingViewController!.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func nextButton(_ sender: Any) {
  }
  @IBOutlet weak var nextButton: UIButton!
 
  var scene: PlaceFurnitureScene?
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if let view = self.view as! SKView? {
      scene = SKScene(fileNamed: "PlaceFurnitureScene") as? PlaceFurnitureScene
      if let scene = scene {
        scene.myHome = myHome
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
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
}
extension PlaceFurnitureViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    //    debug.console(message: "start", file: #file, function: #function, line: #line)
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    debug.console(message: "start", file: #file, function: #function, line: #line)
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //    debug.console(message: "start", file: #file, function: #function, line: #line)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeFurnitureCell", for: indexPath)
    let lbl = UILabel(frame: cell.contentView.frame)
    lbl.textColor = UIColor.green
    lbl.textAlignment = .center
    lbl.text = "Cell: \(indexPath.row + 1)"
    cell.addSubview(lbl)
    return cell
  }
}

extension PlaceFurnitureViewController: UICollectionViewDelegate {
}
