class RoomShapeModel {
  let debug = Debug() // debugger functionality

  
  func processCell( index: Int) -> Bool {
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
  
  struct Point {
    var x: Int
    var y: Int
  }
  
//  var edge : [Point] = []
  var myHome : Home?
  
  private let addFrame4    = [ true,  true, false,  true,  true, false,  true,  true]
  private let removeFrame4 = [ true,  true,  true,  true,  true, false,  true,  true]
  private let addFrame6    = [ true,  true, false,  true,  true, false,  true,  true,
                               false, false, false, false,  true, false,  true,  true,
                               true, false, false, false, false, false, false, false,
                               true, false, false, false,  true, false,  true,  true]
  private let removeFrame6 = [ true,  true,  true,  true,  true, false,  true,  true,
                               true,  true,  true,  true,  true, false,  true,  true,
                               true, false,  true, false, false, false, false, false,
                               true, false,  true, false,  true, false,  true,  true]
  private let addFrame9    = [ true,  true, false,  true,  true, false,  true,  true,
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
  private let removeFrame9 = [ true,  true,  true,  true,  true, false,  true,  true,
                               true, false, false, false,  true, false,  true,  true,
                               true, false, false, false, false, false, false, false,
                               true, false, false, false,  true, false,  true,  true,
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
  
  private var cellN  = false
  private var cellNE = false
  private var cellE  = false
  private var cellSE = false
  private var cellS  = false
  private var cellSW = false
  private var cellW  = false
  private var cellNW = false
  
  private enum Angle {
    case Normal
    case Right
    case Half
    case Left
  }
  
  private let index2Point = [ Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0), Point(x: 4, y: 0), Point(x: 5, y: 0), Point(x: 6, y: 0),
                              Point(x: 0, y: 1), Point(x: 1, y: 1), Point(x: 2, y: 1), Point(x: 3, y: 1), Point(x: 4, y: 1), Point(x: 5, y: 1), Point(x: 6, y: 1),
                              Point(x: 0, y: 2), Point(x: 1, y: 2), Point(x: 2, y: 2), Point(x: 3, y: 2), Point(x: 4, y: 2), Point(x: 5, y: 2), Point(x: 6, y: 2),
                              Point(x: 0, y: 3), Point(x: 1, y: 3), Point(x: 2, y: 3), Point(x: 3, y: 3), Point(x: 4, y: 3), Point(x: 5, y: 3), Point(x: 6, y: 3),
                              Point(x: 0, y: 4), Point(x: 1, y: 4), Point(x: 2, y: 4), Point(x: 3, y: 4), Point(x: 4, y: 4), Point(x: 5, y: 4), Point(x: 6, y: 4),
                              Point(x: 0, y: 5), Point(x: 1, y: 5), Point(x: 2, y: 5), Point(x: 3, y: 5), Point(x: 4, y: 5), Point(x: 5, y: 5), Point(x: 6, y: 5),
                              Point(x: 0, y: 6), Point(x: 1, y: 6), Point(x: 2, y: 6), Point(x: 3, y: 6), Point(x: 4, y: 6), Point(x: 5, y: 6), Point(x: 6, y: 6)]
  
  private func allowedCorner( index: Int, angle: Angle) -> Bool {
    let currentPoint = index2Point[index]
    switch angle {
    case .Normal:
      cellE  = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
    case .Right:
      cellE  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
    case .Half:
      cellE  = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
    case .Left:
      cellE  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
    }
    var sum = 0
    sum += cellE  ? 1 : 0
    sum += cellSE ? 2 : 0
    sum += cellS  ? 4 : 0
    if let myHome = myHome {
      if currentCellIsCollored[index] {
        if removeFrame4[sum] {
          currentCellIsCollored[index] = false
          myHome.rooms[myHome.selectedRoom].countCell -= 1
        }
      } else {
        if myHome.rooms[myHome.selectedRoom].countCell == 0 {
          currentCellIsCollored[index] = true
          myHome.rooms[myHome.selectedRoom].countCell += 1
        } else {
          if sum != 0 {
            if addFrame4[sum] {
              currentCellIsCollored[index] = true
              myHome.rooms[myHome.selectedRoom].countCell += 1
            }
          }
        }
      }
    }
    return currentCellIsCollored[index]
  }
  
  private func allowedSide( index: Int, angle: Angle) -> Bool {
    let currentPoint = index2Point[index]
    switch angle {
    case .Normal:
      cellN  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellNE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellE  = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
    case .Right:
      cellN  = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellNE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellE  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
    case .Half:
      cellN  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellNE = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellE  = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
    case .Left:
      cellN  = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellNE = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      cellE  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellSE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellS  = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
    }
    var sum = 0
    sum += cellN  ?  1 : 0
    sum += cellNE ?  2 : 0
    sum += cellE  ?  4 : 0
    sum += cellSE ?  8 : 0
    sum += cellS  ? 16 : 0
    if let myHome = myHome {
      if currentCellIsCollored[index] {
        if removeFrame6[sum] {
          currentCellIsCollored[index] = false
          myHome.rooms[myHome.selectedRoom].countCell -= 1
        }
      } else {
        if myHome.rooms[myHome.selectedRoom].countCell == 0 {
          currentCellIsCollored[index] = true
          myHome.rooms[myHome.selectedRoom].countCell += 1
        } else {
          if sum != 0 {
            if addFrame6[sum] {
              currentCellIsCollored[index] = true
              myHome.rooms[myHome.selectedRoom].countCell += 1
            }
          }
        }
      }
    }
    return currentCellIsCollored[index]
  }
  
  private func allowedInner( index: Int) -> Bool {
    let currentPoint = index2Point[index]
    cellN  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
    cellNE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
    cellE  = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
    cellSE = currentCellIsCollored[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
    cellS  = currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
    cellSW = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
    cellW  = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
    cellNW = currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
    var sum = 0
    sum += cellN  ?   1 : 0
    sum += cellNE ?   2 : 0
    sum += cellE  ?   4 : 0
    sum += cellSE ?   8 : 0
    sum += cellS  ?  16 : 0
    sum += cellSW ?  32 : 0
    sum += cellW  ?  64 : 0
    sum += cellNW ? 128 : 0
    if let myHome = myHome {
      if currentCellIsCollored[index] {
        if removeFrame9[sum] {
          currentCellIsCollored[index] = false
          myHome.rooms[myHome.selectedRoom].countCell -= 1
        }
      } else {
        if myHome.rooms[myHome.selectedRoom].countCell == 0 {
          currentCellIsCollored[index] = true
          myHome.rooms[myHome.selectedRoom].countCell += 1
        } else {
          if sum != 0 {
            if addFrame9[sum] {
              currentCellIsCollored[index] = true
              myHome.rooms[myHome.selectedRoom].countCell += 1
            }
          }
        }
      }
    }
    return currentCellIsCollored[index]
  }
  
  func processNext () -> [Point] {
    if let myHome = myHome {
      if myHome.rooms[myHome.selectedRoom].countCell == 0 {
        return []
      } else {
        
        var minimumIndex = currentCellIsCollored.count
        for index in 0 ..< currentCellIsCollored.count {
          if currentCellIsCollored[index] {
            if index < minimumIndex {
              minimumIndex = index
            }
          }
        }
        var corner = [index2Point[minimumIndex]]
        var currentPoint = corner[0]
        var currentAngle : Angle = .Normal
        var nextPoint = Point(x: currentPoint.x + 1, y: currentPoint.y)
        while !(corner[0].x == nextPoint.x && corner[0].y == nextPoint.y) {
          currentPoint = nextPoint
          switch currentAngle {
          case .Normal:
            if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Left
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              nextPoint = Point(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            }
          case .Left:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = Point(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = Point(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            }
          case .Right:
            if  (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && currentCellIsCollored[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = Point(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = Point(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            }
          case .Half:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && currentCellIsCollored[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
              nextPoint = Point(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            } else {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Left
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            }
          }
        }
        debug.console(message: "corner = \(corner)", file: #file, function: #function, line: #line)

        return corner
      }
    } else {
      return []
    }

  }
  
  var currentCellIsCollored = Array(repeating: Bool(), count: 49)
}
