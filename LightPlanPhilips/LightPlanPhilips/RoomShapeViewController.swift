import UIKit

class RoomShapeViewController: UIViewController {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  
  @IBAction func backButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  @IBAction func cancelButton(_ sender: Any) {
    self.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
  }
  @IBAction func cellButton(_ sender: Any) {
    let cellButton = sender as! UIButton
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      roomShapeModel.processCell( index: Int(cellButton.currentTitle!)!) ? cellButton.color(rgbValue: 0xE7BF7E) : cellButton.color(rgbValue: 0xD8D8D8)
      nextButton.isHidden = myRoom.countCell > 0 ? false : true
    }
  }
  
  @IBAction func nextButton(_ sender: Any) {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      myRoom.gridCorners = roomShapeModel.processNext()
    }
  }
  
  @IBOutlet weak var nextButton: UIButton!
  
  @IBOutlet weak var gridButton_0_0: UIButton!
  @IBOutlet weak var gridButton_1_0: UIButton!
  @IBOutlet weak var gridButton_2_0: UIButton!
  @IBOutlet weak var gridButton_3_0: UIButton!
  @IBOutlet weak var gridButton_4_0: UIButton!
  @IBOutlet weak var gridButton_5_0: UIButton!
  @IBOutlet weak var gridButton_6_0: UIButton!
  @IBOutlet weak var gridButton_0_1: UIButton!
  @IBOutlet weak var gridButton_1_1: UIButton!
  @IBOutlet weak var gridButton_2_1: UIButton!
  @IBOutlet weak var gridButton_3_1: UIButton!
  @IBOutlet weak var gridButton_4_1: UIButton!
  @IBOutlet weak var gridButton_5_1: UIButton!
  @IBOutlet weak var gridButton_6_1: UIButton!
  @IBOutlet weak var gridButton_0_2: UIButton!
  @IBOutlet weak var gridButton_1_2: UIButton!
  @IBOutlet weak var gridButton_2_2: UIButton!
  @IBOutlet weak var gridButton_3_2: UIButton!
  @IBOutlet weak var gridButton_4_2: UIButton!
  @IBOutlet weak var gridButton_5_2: UIButton!
  @IBOutlet weak var gridButton_6_2: UIButton!
  @IBOutlet weak var gridButton_0_3: UIButton!
  @IBOutlet weak var gridButton_1_3: UIButton!
  @IBOutlet weak var gridButton_2_3: UIButton!
  @IBOutlet weak var gridButton_3_3: UIButton!
  @IBOutlet weak var gridButton_4_3: UIButton!
  @IBOutlet weak var gridButton_5_3: UIButton!
  @IBOutlet weak var gridButton_6_3: UIButton!
  @IBOutlet weak var gridButton_0_4: UIButton!
  @IBOutlet weak var gridButton_1_4: UIButton!
  @IBOutlet weak var gridButton_2_4: UIButton!
  @IBOutlet weak var gridButton_3_4: UIButton!
  @IBOutlet weak var gridButton_4_4: UIButton!
  @IBOutlet weak var gridButton_5_4: UIButton!
  @IBOutlet weak var gridButton_6_4: UIButton!
  @IBOutlet weak var gridButton_0_5: UIButton!
  @IBOutlet weak var gridButton_1_5: UIButton!
  @IBOutlet weak var gridButton_2_5: UIButton!
  @IBOutlet weak var gridButton_3_5: UIButton!
  @IBOutlet weak var gridButton_4_5: UIButton!
  @IBOutlet weak var gridButton_5_5: UIButton!
  @IBOutlet weak var gridButton_6_5: UIButton!
  @IBOutlet weak var gridButton_0_6: UIButton!
  @IBOutlet weak var gridButton_1_6: UIButton!
  @IBOutlet weak var gridButton_2_6: UIButton!
  @IBOutlet weak var gridButton_3_6: UIButton!
  @IBOutlet weak var gridButton_4_6: UIButton!
  @IBOutlet weak var gridButton_5_6: UIButton!
  @IBOutlet weak var gridButton_6_6: UIButton!
  
  var roomShapeModel = RoomShapeModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      roomShapeModel.myHome = myHome
      var gridButtons : [UIButton] = []
      gridButtons.append(gridButton_0_0)
      gridButtons.append(gridButton_1_0)
      gridButtons.append(gridButton_2_0)
      gridButtons.append(gridButton_3_0)
      gridButtons.append(gridButton_4_0)
      gridButtons.append(gridButton_5_0)
      gridButtons.append(gridButton_6_0)
      gridButtons.append(gridButton_0_1)
      gridButtons.append(gridButton_1_1)
      gridButtons.append(gridButton_2_1)
      gridButtons.append(gridButton_3_1)
      gridButtons.append(gridButton_4_1)
      gridButtons.append(gridButton_5_1)
      gridButtons.append(gridButton_6_1)
      gridButtons.append(gridButton_0_2)
      gridButtons.append(gridButton_1_2)
      gridButtons.append(gridButton_2_2)
      gridButtons.append(gridButton_3_2)
      gridButtons.append(gridButton_4_2)
      gridButtons.append(gridButton_5_2)
      gridButtons.append(gridButton_6_2)
      gridButtons.append(gridButton_0_3)
      gridButtons.append(gridButton_1_3)
      gridButtons.append(gridButton_2_3)
      gridButtons.append(gridButton_3_3)
      gridButtons.append(gridButton_4_3)
      gridButtons.append(gridButton_5_3)
      gridButtons.append(gridButton_6_3)
      gridButtons.append(gridButton_0_4)
      gridButtons.append(gridButton_1_4)
      gridButtons.append(gridButton_2_4)
      gridButtons.append(gridButton_3_4)
      gridButtons.append(gridButton_4_4)
      gridButtons.append(gridButton_5_4)
      gridButtons.append(gridButton_6_4)
      gridButtons.append(gridButton_0_5)
      gridButtons.append(gridButton_1_5)
      gridButtons.append(gridButton_2_5)
      gridButtons.append(gridButton_3_5)
      gridButtons.append(gridButton_4_5)
      gridButtons.append(gridButton_5_5)
      gridButtons.append(gridButton_6_5)
      gridButtons.append(gridButton_0_6)
      gridButtons.append(gridButton_1_6)
      gridButtons.append(gridButton_2_6)
      gridButtons.append(gridButton_3_6)
      gridButtons.append(gridButton_4_6)
      gridButtons.append(gridButton_5_6)
      gridButtons.append(gridButton_6_6)
      myRoom.countCell = 0
      nextButton.isHidden = true
      for index in 0 ..< gridButtons.count {
        if myRoom.gridCellUser[index] {
          gridButtons[index].color(rgbValue: 0xE7BF7E)
          myRoom.countCell += 1
          myRoom.countGridAxisXUser[roomShapeModel.index2GridPoint[index].x] += 1
          myRoom.countGridAxisYUser[roomShapeModel.index2GridPoint[index].y] += 1
          nextButton.isHidden = false
        } else {
          gridButtons[index].color(rgbValue: 0xD8D8D8)
        }
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    passInformationToNextScene(segue: segue)
  }
  
  private func passInformationToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "RoomSizeAdjustSegue" {
      passInformationToSomewhereScene(segue: segue)
    }
  }
  
  private func passInformationToSomewhereScene(segue: UIStoryboardSegue) {
    if let destination = segue.destination as? RoomSizeAdjustViewController {
      passDataToScene( destination: destination)
      passClosureToScene( destination: destination)
    }
  }
  
  private func passDataToScene (destination: RoomSizeAdjustViewController) {
    if let myHome = myHome {
      destination.myHome = myHome
    }
  }
  
  private func passClosureToScene ( destination: RoomSizeAdjustViewController) {
    destination.closureToPerform = { [weak self] (myHome: Home) in
      if let strongSelf = self {
        strongSelf.myHome = myHome
      }
    }
  }
}

