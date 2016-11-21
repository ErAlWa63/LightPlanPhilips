//
//  RoomShapeViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 16/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class RoomShapeViewController: UIViewController {
  let d = D() // debugger functionality
  
  let addFrame4    = [ true,  true, false,  true,  true, false,  true,  true]
  let removeFrame4 = [ true,  true,  true,  true,  true, false,  true,  true]
  let addFrame6    = [ true,  true, false,  true,  true, false,  true,  true,
                       false, false, false, false,  true, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true,  true]
  let removeFrame6 = [ true,  true,  true,  true,  true, false,  true,  true,
                       true,  true,  true,  true,  true, false,  true,  true,
                       true, false,  true, false, false, false, false, false,
                       true, false,  true, false,  true, false,  true,  true]
  let addFrame9    = [ true,  true, false,  true,  true, false,  true,  true,
                       false, false, false, false,  true, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true,  true,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       true, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true,  true,
                       false,  true, false,  true, false, false, false,  true,
                       false, false, false, false, false, false, false,  true,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false,  true,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false,  true,
                       true,  true, false,  true, false, false, false,  true,
                       false, false, false, false, false, false, false,  true,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false,  true,
                       true,  true, false,  true, false, false, false,  true,
                       false, false, false, false, false, false, false,  true,
                       true,  true, false,  true, false, false, false,  true,
                       true,  true, false,  true,  true,  true,  true,  true]
  let removeFrame9 = [ true,  true,  true,  true,  true, false,  true,  true,
                       true, false, false, false,  true, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false, false, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       true, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true, false,
                       false,  true, false,  true, false, false, false,  true,
                       false, false, false, false, false, false, false,  true,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false,  true,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false,  true,
                       true,  true, false,  true, false, false, false,  true,
                       false, false, false, false, false, false, false,  true,
                       false, false, false, false, false, false, false, false,
                       false, false, false, false, false, false, false, false,
                       true,  true, false,  true, false, false, false,  true,
                       false, false, false, false, false, false, false,  true,
                       true,  true, false,  true, false, false, false, false,
                       true,  true, false,  true,  true, false,  true, false]
  
  var cellN = false
  var cellNE = false
  var cellE = false
  var cellSE = false
  var cellS = false
  var cellSW = false
  var cellW = false
  var cellNW = false
  
  enum Angle {
    case Normal
    case Right
    case Half
    case Left
  }
  
  struct Point {
    var x: Int
    var y: Int
  }
  
  var countCell = 0
  
  let index2Point = [ Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0), Point(x: 4, y: 0), Point(x: 5, y: 0), Point(x: 6, y: 0),
                      Point(x: 0, y: 1), Point(x: 1, y: 1), Point(x: 2, y: 1), Point(x: 3, y: 1), Point(x: 4, y: 1), Point(x: 5, y: 1), Point(x: 6, y: 1),
                      Point(x: 0, y: 2), Point(x: 1, y: 2), Point(x: 2, y: 2), Point(x: 3, y: 2), Point(x: 4, y: 2), Point(x: 5, y: 2), Point(x: 6, y: 2),
                      Point(x: 0, y: 3), Point(x: 1, y: 3), Point(x: 2, y: 3), Point(x: 3, y: 3), Point(x: 4, y: 3), Point(x: 5, y: 3), Point(x: 6, y: 3),
                      Point(x: 0, y: 4), Point(x: 1, y: 4), Point(x: 2, y: 4), Point(x: 3, y: 4), Point(x: 4, y: 4), Point(x: 5, y: 4), Point(x: 6, y: 4),
                      Point(x: 0, y: 5), Point(x: 1, y: 5), Point(x: 2, y: 5), Point(x: 3, y: 5), Point(x: 4, y: 5), Point(x: 5, y: 5), Point(x: 6, y: 5),
                      Point(x: 0, y: 6), Point(x: 1, y: 6), Point(x: 2, y: 6), Point(x: 3, y: 6), Point(x: 4, y: 6), Point(x: 5, y: 6), Point(x: 6, y: 6)]
  
  func allowedCorner( index: Int, angle: Angle) -> Bool {
    let currentPoint = index2Point[index]
    switch angle {
    case .Normal:
      cellE  = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellSE = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellS  = toggle[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
    case .Right:
      cellE  = toggle[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellSE = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellS  = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
    case .Half:
      cellE  = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellSE = toggle[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      cellS  = toggle[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
    case .Left:
      cellE  = toggle[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellSE = toggle[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellS  = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
    }
    var sum = 0
    sum += cellE  ? 1 : 0
    sum += cellSE ? 2 : 0
    sum += cellS  ? 4 : 0
    if toggle[index] {
      if removeFrame4[sum] {
        toggle[index] = false
        countCell -= 1
      }
    } else {
      if countCell == 0 {
        toggle[index] = true
        countCell += 1
      } else {
        if sum != 0 {
          if addFrame4[sum] {
            toggle[index] = true
            countCell += 1
          }
        }
      }
    }
    if countCell > 0 {
      nextButton.isHidden = false
    } else {
      nextButton.isHidden = true
    }
    return toggle[index]
  }
  
  func allowedSide( index: Int, angle: Angle) -> Bool {
    let currentPoint = index2Point[index]
    switch angle {
    case .Normal:
      cellN  = toggle[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellNE = toggle[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellE  = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellSE = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellS  = toggle[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
    case .Right:
      cellN  = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellNE = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellE  = toggle[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellSE = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellS  = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
    case .Half:
      cellN  = toggle[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellNE = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellE  = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellSE = toggle[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      cellS  = toggle[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
    case .Left:
      cellN  = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellNE = toggle[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      cellE  = toggle[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellSE = toggle[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellS  = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
    }
    var sum = 0
    sum += cellN  ?  1 : 0
    sum += cellNE ?  2 : 0
    sum += cellE  ?  4 : 0
    sum += cellSE ?  8 : 0
    sum += cellS  ? 16 : 0
    if toggle[index] {
      if removeFrame6[sum] {
        toggle[index] = false
        countCell -= 1
      }
    } else {
      if countCell == 0 {
        toggle[index] = true
        countCell += 1
      } else {
        if sum != 0 {
          if addFrame6[sum] {
            toggle[index] = true
            countCell += 1
          }
        }
      }
    }
    if countCell > 0 {
      nextButton.isHidden = false
    } else {
      nextButton.isHidden = true
    }
    return toggle[index]
  }
  
  func allowedInner( index: Int) -> Bool {
    let currentPoint = index2Point[index]
    cellN  = toggle[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
    cellNE = toggle[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
    cellE  = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
    cellSE = toggle[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
    cellS  = toggle[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
    cellSW = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
    cellW  = toggle[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
    cellNW = toggle[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
    var sum = 0
    sum += cellN  ?   1 : 0
    sum += cellNE ?   2 : 0
    sum += cellE  ?   4 : 0
    sum += cellSE ?   8 : 0
    sum += cellS  ?  16 : 0
    sum += cellSW ?  32 : 0
    sum += cellW  ?  64 : 0
    sum += cellNW ? 128 : 0
    if toggle[index] {
      if removeFrame9[sum] {
        toggle[index] = false
        countCell -= 1
      }
    } else {
      if countCell == 0 {
        toggle[index] = true
        countCell += 1
      } else {
        if sum != 0 {
          if addFrame9[sum] {
            toggle[index] = true
            countCell += 1
          }
        }
      }
    }
    if countCell > 0 {
      nextButton.isHidden = false
    } else {
      nextButton.isHidden = true
    }
    return toggle[index]
  }
  
  @IBAction func cellButton(_ sender: Any) {
//    d.c(m: "start", f: #file, fu: #function, l: #line)
    
    let cellButton = sender as! UIButton
    let interim = processCell( index: Int(cellButton.currentTitle!)!)
    if interim {
//      d.c(m: "interim = \(interim)", f: #file, fu: #function, l: #line)
      
      cellButton.backgroundColor = UIColorFromRGB(rgbValue: 0xE7BF7E)
      cellButton.setTitleColor(UIColorFromRGB(rgbValue: 0xE7BF7E), for: .normal)
    } else {
      cellButton.backgroundColor = UIColorFromRGB(rgbValue: 0xD8D8D8)
      cellButton.setTitleColor(UIColorFromRGB(rgbValue: 0xD8D8D8), for: .normal)
    }
    //    toggle[cellIndex] = !toggle[cellIndex]
    
  }
  
  @IBAction func nextButton(_ sender: Any) {
    var minimumIndex = toggle.count
    for index in 0 ..< toggle.count {
      if toggle[index] {
        if index < minimumIndex {
          minimumIndex = index
        }
      }
    }
    d.c(m: "minimumIndex = \(minimumIndex)", f: #file, fu: #function, l: #line)
    let startpoint = index2Point[minimumIndex]
    d.c(m: "startpoint = \(startpoint)", f: #file, fu: #function, l: #line)

    

  }
  @IBOutlet weak var nextButton: UIButton!
  
  func processCell( index: Int) -> Bool {
//    d.c(m: "start", f: #file, fu: #function, l: #line)
    
    switch index {
    case 0:                                                                         return allowedCorner(index: index, angle: .Normal)
    case 6:                                                                         return allowedCorner(index: index, angle: .Right)
    case 42:                                                                        return allowedCorner(index: index, angle: .Left)
    case 48:                                                                        return allowedCorner(index: index, angle: .Half)
    case 1,2,3,4,5:                                                                 return allowedSide(  index: index, angle: .Right)
    case 13,20,27,34,41:                                                            return allowedSide(  index: index, angle: .Half)
    case 43,44,45,46,47:                                                            return allowedSide(  index: index, angle: .Left)
    case 7,14,21,28,35:                                                             return allowedSide(  index: index, angle: .Normal)
    case 8,9,10,11,12,15,16,17,18,19,22,23,24,25,26,29,30,31,32,33,36,37,38,39,40:  return allowedInner( index: index)
    default: return false
    }
  }
  
  struct Cell {
    var Point = (0, 0)
    var cell = false
    
  }
  
  var toggle = Array(repeating: Bool(), count: 49)
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    toggle = toggle.map{ _ in false}
    nextButton.isHidden = true
  }
  
  func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
