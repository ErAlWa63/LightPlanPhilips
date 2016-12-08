import UIKit
import SpriteKit

class RoomSizeAdjustViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  
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
  
  var scene: RoomSizeAdjustScene?
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let view = self.view as! SKView? {
      scene = SKScene(fileNamed: "RoomSizeAdjustScene") as? RoomSizeAdjustScene
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
    if segue.identifier == "PlaceFurnitureSegue" {
      passInformationToSomewhereScene(segue: segue)
    }
  }
  
  private func passInformationToSomewhereScene(segue: UIStoryboardSegue) {
    if let destination = segue.destination as? PlaceFurnitureViewController {
      passDataToScene( destination: destination)
      passClosureToScene( destination: destination)
    }
  }
  
  private func passDataToScene (destination: PlaceFurnitureViewController) {
    if let myHome = myHome {
      destination.myHome = myHome
    }
  }
  
  private func passClosureToScene ( destination: PlaceFurnitureViewController) {
    destination.closureToPerform = { [weak self] (myHome: Home) in
      if let strongSelf = self {
        strongSelf.myHome = myHome
      }
    }
  }
}
