import UIKit
import SpriteKit

class RoomSizeAdjustViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?

  let debug = Debug() // debugger functionality
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  var scene: RoomSizeAdjustScene?
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
   if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomSizeAdjustScene") as? RoomSizeAdjustScene
      if let scene = scene {
        scene.scaleMode = .aspectFill
        
        //        scene.roomSceneDelegate = self
        view.presentScene(scene)
        
        scene.dragDropEnabled = false
        scene.createGroup = false
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
      }
    }
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
//  private func saveBulbs(){
//    if let scene = scene {
//      scene.enumerateChildNodes(withName: "//*", using:
//        { (node, stop) -> Void in
//          if node is SKSpriteNode {
//            for bulb in self.bulbCollection {
//              if bulb.name == node.name {
//                bulb.positionX = Float(node.position.x)
//                bulb.positionY = Float(node.position.y)
//                break
//              }
//            }
//          }
//      }
//      )
//    }
//  }
}

  // delegate functions
  internal func groupSelected(groupSelected: Bool) {
    // not used here
  }
  func selectedBulbs(bulbs: [Bulb]){
    
  }
  
  
//}
