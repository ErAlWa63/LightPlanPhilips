import UIKit

class PlaceFurnitureViewController: UIViewController {
  let debug = Debug() // debugger functionality

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
