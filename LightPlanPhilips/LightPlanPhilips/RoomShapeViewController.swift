import UIKit

class RoomShapeViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  var roomShapeModel = RoomShapeModel()
  
  @IBAction func backButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelButton(_ sender: Any) {
    self.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cellButton(_ sender: Any) {
    let cellButton = sender as! UIButton
    roomShapeModel.processCell( index: Int(cellButton.currentTitle!)!) ? cellButton.color(rgbValue: 0xE7BF7E) : cellButton.color(rgbValue: 0xD8D8D8)
    nextButton.isHidden = roomShapeModel.countCell > 0 ? false : true
  }
  
  @IBAction func nextButton(_ sender: Any) {
//    DataLightPlan.sharedInstance.edge = DataLightPlan.sharedInstance.processNext()
  }
  
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    DataLightPlan.sharedInstance.toggle = DataLightPlan.sharedInstance.toggle.map{ _ in false}
    nextButton.isHidden = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

