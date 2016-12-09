import UIKit

class LightPlanCreatorViewController: UIViewController {
  private var myHome : Home?
  
  @IBAction func startButton(_ sender: Any) {
    let myRoomViewController = MyRoomViewController()
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCATransitionPush
    transition.subtype = kCATransitionFromRight
    view.window!.layer.add(transition, forKey: kCATransition)
    present(myRoomViewController, animated: false, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    passInformationToNextScene(segue: segue)
  }
  
  private func passInformationToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "MyRoomSegue" {
      passInformationToSomewhereScene(segue: segue)
    }
  }
  
  private func passInformationToSomewhereScene(segue: UIStoryboardSegue) {
    if let destination = segue.destination as? MyRoomViewController {
      passDataToScene( destination: destination)
      passClosureToScene( destination: destination)
    }
  }
  
  private func passDataToScene (destination: MyRoomViewController) {
    if let myHome = myHome {
      destination.myHome = myHome
    }
  }
  
  private func passClosureToScene ( destination: MyRoomViewController) {
    destination.closureToPerform = { [weak self] (myHome: Home) in
      if let strongSelf = self {
        strongSelf.myHome = myHome
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if myHome == nil {
      DataSource.sharedInstance.createData()
      myHome = DataSource.sharedInstance.myHome
    }
  }
}
