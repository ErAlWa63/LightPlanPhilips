import UIKit
import SpriteKit

class RoomSizeAdjustViewController: UIViewController {
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
  
  var scene: RoomSizeAdjustScene?
  override func viewDidLoad() {
    super.viewDidLoad()
    nextButton.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomSizeAdjustScene") as? RoomSizeAdjustScene
      if let scene = scene {
        scene.myHome = myHome
        scene.scaleMode = .aspectFill
        
        //        scene.roomSceneDelegate = self
        view.presentScene(scene)
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
      }
    }
  }
}
