//
//  RoomShapeViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 16/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class RoomShapeViewController: UIViewController {
  let addFrame4    = [ true,  true, false,  true,  true, false,  true,  true]
  let removeFrame4 = [ true,  true,  true,  true,  true, false,  true,  true]
  let addFrame6    = [ true,  true, false,  true,  true, false,  true,  true,
                       false, false, false, false,  true, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true,  true]
  let removeFrame6 = [ true]
  let addFrame9    = [ true]
  let removeFrame9 = [ true]
  
  var cellN = false
  var cellNE = false
  var cellE = false
  var cellSE = false
  var cellS = false
  var cellSW = false
  var cellW = false
  var cellNW = false
  
  enum Operation {
    case Corner((Int, Angle) -> Bool)
    case Side((Int, Angle) -> Bool)
    case Inner((Int) -> Bool)
  }
  
  enum Angle {
    case Normal
    case Right
    case Half
    case Left
  }
  //  func performOperation(index: Int) {
  //    if let operation = operations[index] {
  //      switch operation {
  //      case
  //    }
  //  }
  
//  var operations = [ Operation.Corner(allowedCorner(index: 0, Angle.Normal)),
//                     Operation.Side(allowedSide( index: 1, Angle.Right)),
//                     Operation.Side(allowedSide( index: 2, Angle.Right)),
//                     Operation.Side(allowedSide( index: 3, Angle.Right)),
//                     Operation.Side(allowedSide( index: 4, Angle.Right)),
//                     Operation.Side(allowedSide( index: 5, Angle.Right)),
//                     Operation.Corner(allowedCorner(index: 6, Angle.Right)),
//                     Operation.Side(allowedSide(index: 7, Angle.Normal)),
//                     Operation.Inner(allowedInner(index: 8)),
//                     Operation.Inner(allowedInner(index: 9)),
//                     Operation.Inner(allowedInner(index: 10)),
//    Operation.Inner(allowedInner(index: 11)),
//    Operation.Inner(allowedInner(index: 12)),
//    Operation.Side(allowedSide(index: 13, Angle.Half)),
//    Operation.Inner(allowedInner(index: 13))
//    
//  ]
  
  
  func allowedCorner( index: Int, angle: Angle) -> Bool {
    return true
  }
  
  func allowedSide( index: Int, angle: Angle) -> Bool {
    return true
  }
  
  func allowedInner( index: Int) -> Bool {
    return true
  }
  
  @IBAction func cellButton(_ sender: Any) {
    let cellButton = sender as! UIButton
    let cellIndex = Int(cellButton.currentTitle!)!
    if toggle[cellIndex] {
      cellButton.backgroundColor = UIColorFromRGB(rgbValue: 0xD8D8D8)
      cellButton.setTitleColor(UIColorFromRGB(rgbValue: 0xD8D8D8), for: .normal)
    } else {
      cellButton.backgroundColor = UIColorFromRGB(rgbValue: 0xE7BF7E)
      cellButton.setTitleColor(UIColorFromRGB(rgbValue: 0xE7BF7E), for: .normal)
    }
    toggle[cellIndex] = !toggle[cellIndex]
    
  }
  struct Point {
    var x: Int
    var y: Int
    init () {
      x = 0
      y = 0
    }
  }
  //  let index2Point = [ Point(0,0), Point(1,0)]
  
  struct Cell {
    var Point = (0, 0)
    var state = false
    
  }
  
  var toggle = Array(repeating: Bool(), count: 49)
  
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    toggle = toggle.map{ _ in false}
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
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
