class RoomShapeModel {
  var myHome : Home?
  
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
  
  let index2Point = [ Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0), Point(x: 4, y: 0), Point(x: 5, y: 0), Point(x: 6, y: 0),
                      Point(x: 0, y: 1), Point(x: 1, y: 1), Point(x: 2, y: 1), Point(x: 3, y: 1), Point(x: 4, y: 1), Point(x: 5, y: 1), Point(x: 6, y: 1),
                      Point(x: 0, y: 2), Point(x: 1, y: 2), Point(x: 2, y: 2), Point(x: 3, y: 2), Point(x: 4, y: 2), Point(x: 5, y: 2), Point(x: 6, y: 2),
                      Point(x: 0, y: 3), Point(x: 1, y: 3), Point(x: 2, y: 3), Point(x: 3, y: 3), Point(x: 4, y: 3), Point(x: 5, y: 3), Point(x: 6, y: 3),
                      Point(x: 0, y: 4), Point(x: 1, y: 4), Point(x: 2, y: 4), Point(x: 3, y: 4), Point(x: 4, y: 4), Point(x: 5, y: 4), Point(x: 6, y: 4),
                      Point(x: 0, y: 5), Point(x: 1, y: 5), Point(x: 2, y: 5), Point(x: 3, y: 5), Point(x: 4, y: 5), Point(x: 5, y: 5), Point(x: 6, y: 5),
                      Point(x: 0, y: 6), Point(x: 1, y: 6), Point(x: 2, y: 6), Point(x: 3, y: 6), Point(x: 4, y: 6), Point(x: 5, y: 6), Point(x: 6, y: 6)]
  
  private func allowedCorner( index: Int, angle: Angle) -> Bool {
    if let myHome = myHome {
      let currentPoint = index2Point[index]
      switch angle {
      case .Normal:
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      case .Right:
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      case .Half:
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      case .Left:
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      }
      var sum = 0
      sum += cellE  ? 1 : 0
      sum += cellSE ? 2 : 0
      sum += cellS  ? 4 : 0
      if myHome.rooms[myHome.selectedRoom].gridCell[index] {
        if removeFrame4[sum] {
          myHome.rooms[myHome.selectedRoom].gridCell[index] = false
          myHome.rooms[myHome.selectedRoom].countCell -= 1
          myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] -= 1
          myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] -= 1
        }
      } else {
        if myHome.rooms[myHome.selectedRoom].countCell == 0 {
          myHome.rooms[myHome.selectedRoom].gridCell[index] = true
          myHome.rooms[myHome.selectedRoom].countCell += 1
          myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] += 1
          myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame4[sum] {
              myHome.rooms[myHome.selectedRoom].gridCell[index] = true
              myHome.rooms[myHome.selectedRoom].countCell += 1
              myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] += 1
              myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] += 1
            }
          }
        }
      }
      return myHome.rooms[myHome.selectedRoom].gridCell[index]
    } else {
      return false
    }
  }
  
  private func allowedSide( index: Int, angle: Angle) -> Bool {
    if let myHome = myHome {
      let currentPoint = index2Point[index]
      switch angle {
      case .Normal:
        cellN  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellNE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      case .Right:
        cellN  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellNE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      case .Half:
        cellN  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellNE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      case .Left:
        cellN  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellNE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      }
      var sum = 0
      sum += cellN  ?  1 : 0
      sum += cellNE ?  2 : 0
      sum += cellE  ?  4 : 0
      sum += cellSE ?  8 : 0
      sum += cellS  ? 16 : 0
      if myHome.rooms[myHome.selectedRoom].gridCell[index] {
        if removeFrame6[sum] {
          myHome.rooms[myHome.selectedRoom].gridCell[index] = false
          myHome.rooms[myHome.selectedRoom].countCell -= 1
          myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] -= 1
          myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] -= 1
        }
      } else {
        if myHome.rooms[myHome.selectedRoom].countCell == 0 {
          myHome.rooms[myHome.selectedRoom].gridCell[index] = true
          myHome.rooms[myHome.selectedRoom].countCell += 1
          myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] += 1
          myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame6[sum] {
              myHome.rooms[myHome.selectedRoom].gridCell[index] = true
              myHome.rooms[myHome.selectedRoom].countCell += 1
              myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] += 1
              myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] += 1
            }
          }
        }
      }
      return myHome.rooms[myHome.selectedRoom].gridCell[index]
    } else {
      return false
    }
  }
  
  private func allowedInner( index: Int) -> Bool {
    if let myHome = myHome {
      let currentPoint = index2Point[index]
      cellN  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellNE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellE  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellSE = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellS  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellSW = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellW  = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellNW = myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      var sum = 0
      sum += cellN  ?   1 : 0
      sum += cellNE ?   2 : 0
      sum += cellE  ?   4 : 0
      sum += cellSE ?   8 : 0
      sum += cellS  ?  16 : 0
      sum += cellSW ?  32 : 0
      sum += cellW  ?  64 : 0
      sum += cellNW ? 128 : 0
      if myHome.rooms[myHome.selectedRoom].gridCell[index] {
        if removeFrame9[sum] {
          myHome.rooms[myHome.selectedRoom].gridCell[index] = false
          myHome.rooms[myHome.selectedRoom].countCell -= 1
          myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] -= 1
          myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] -= 1
        }
      } else {
        if myHome.rooms[myHome.selectedRoom].countCell == 0 {
          myHome.rooms[myHome.selectedRoom].gridCell[index] = true
          myHome.rooms[myHome.selectedRoom].countCell += 1
          myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] += 1
          myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame9[sum] {
              myHome.rooms[myHome.selectedRoom].gridCell[index] = true
              myHome.rooms[myHome.selectedRoom].countCell += 1
              myHome.rooms[myHome.selectedRoom].countGridAxisX[index2Point[index].x] += 1
              myHome.rooms[myHome.selectedRoom].countGridAxisY[index2Point[index].y] += 1
            }
          }
        }
      }
      return myHome.rooms[myHome.selectedRoom].gridCell[index]
    } else {
      return false
    }
  }
  
  func processNext () -> [Point] {
    if let myHome = myHome {
      if myHome.rooms[myHome.selectedRoom].countCell == 0 {
        return []
      } else {
        
        myHome.rooms[myHome.selectedRoom].gridCellBackup = myHome.rooms[myHome.selectedRoom].gridCell
        
        debug.console(message: "myHome.rooms[myHome.selectedRoom].countGridAxisX = \(myHome.rooms[myHome.selectedRoom].countGridAxisX)", file: #file, function: #function, line: #line)
        debug.console(message: "myHome.rooms[myHome.selectedRoom].countGridAxisY = \(myHome.rooms[myHome.selectedRoom].countGridAxisY)", file: #file, function: #function, line: #line)
        
        
        while myHome.rooms[myHome.selectedRoom].countGridAxisX[0] == 0 {
          myHome.rooms[myHome.selectedRoom].countGridAxisX[0] = myHome.rooms[myHome.selectedRoom].countGridAxisX[1]
          myHome.rooms[myHome.selectedRoom].countGridAxisX[1] = myHome.rooms[myHome.selectedRoom].countGridAxisX[2]
          myHome.rooms[myHome.selectedRoom].countGridAxisX[2] = myHome.rooms[myHome.selectedRoom].countGridAxisX[3]
          myHome.rooms[myHome.selectedRoom].countGridAxisX[3] = myHome.rooms[myHome.selectedRoom].countGridAxisX[4]
          myHome.rooms[myHome.selectedRoom].countGridAxisX[4] = myHome.rooms[myHome.selectedRoom].countGridAxisX[5]
          myHome.rooms[myHome.selectedRoom].countGridAxisX[5] = myHome.rooms[myHome.selectedRoom].countGridAxisX[6]
          myHome.rooms[myHome.selectedRoom].countGridAxisX[6] = 0
          debug.console(message: "myHome.rooms[myHome.selectedRoom].countGridAxisX = \(myHome.rooms[myHome.selectedRoom].countGridAxisX)", file: #file, function: #function, line: #line)
          myHome.rooms[myHome.selectedRoom].gridCell[0] = myHome.rooms[myHome.selectedRoom].gridCell[1]
          myHome.rooms[myHome.selectedRoom].gridCell[1] = myHome.rooms[myHome.selectedRoom].gridCell[2]
          myHome.rooms[myHome.selectedRoom].gridCell[2] = myHome.rooms[myHome.selectedRoom].gridCell[3]
          myHome.rooms[myHome.selectedRoom].gridCell[3] = myHome.rooms[myHome.selectedRoom].gridCell[4]
          myHome.rooms[myHome.selectedRoom].gridCell[4] = myHome.rooms[myHome.selectedRoom].gridCell[5]
          myHome.rooms[myHome.selectedRoom].gridCell[5] = myHome.rooms[myHome.selectedRoom].gridCell[6]
          myHome.rooms[myHome.selectedRoom].gridCell[6] = false
          myHome.rooms[myHome.selectedRoom].gridCell[7] = myHome.rooms[myHome.selectedRoom].gridCell[8]
          myHome.rooms[myHome.selectedRoom].gridCell[8] = myHome.rooms[myHome.selectedRoom].gridCell[9]
          myHome.rooms[myHome.selectedRoom].gridCell[9] = myHome.rooms[myHome.selectedRoom].gridCell[10]
          myHome.rooms[myHome.selectedRoom].gridCell[10] = myHome.rooms[myHome.selectedRoom].gridCell[11]
          myHome.rooms[myHome.selectedRoom].gridCell[11] = myHome.rooms[myHome.selectedRoom].gridCell[12]
          myHome.rooms[myHome.selectedRoom].gridCell[12] = myHome.rooms[myHome.selectedRoom].gridCell[13]
          myHome.rooms[myHome.selectedRoom].gridCell[13] = false
          myHome.rooms[myHome.selectedRoom].gridCell[14] = myHome.rooms[myHome.selectedRoom].gridCell[15]
          myHome.rooms[myHome.selectedRoom].gridCell[15] = myHome.rooms[myHome.selectedRoom].gridCell[16]
          myHome.rooms[myHome.selectedRoom].gridCell[16] = myHome.rooms[myHome.selectedRoom].gridCell[17]
          myHome.rooms[myHome.selectedRoom].gridCell[17] = myHome.rooms[myHome.selectedRoom].gridCell[18]
          myHome.rooms[myHome.selectedRoom].gridCell[18] = myHome.rooms[myHome.selectedRoom].gridCell[19]
          myHome.rooms[myHome.selectedRoom].gridCell[19] = myHome.rooms[myHome.selectedRoom].gridCell[20]
          myHome.rooms[myHome.selectedRoom].gridCell[20] = false
          myHome.rooms[myHome.selectedRoom].gridCell[21] = myHome.rooms[myHome.selectedRoom].gridCell[22]
          myHome.rooms[myHome.selectedRoom].gridCell[22] = myHome.rooms[myHome.selectedRoom].gridCell[23]
          myHome.rooms[myHome.selectedRoom].gridCell[23] = myHome.rooms[myHome.selectedRoom].gridCell[24]
          myHome.rooms[myHome.selectedRoom].gridCell[24] = myHome.rooms[myHome.selectedRoom].gridCell[25]
          myHome.rooms[myHome.selectedRoom].gridCell[25] = myHome.rooms[myHome.selectedRoom].gridCell[26]
          myHome.rooms[myHome.selectedRoom].gridCell[26] = myHome.rooms[myHome.selectedRoom].gridCell[27]
          myHome.rooms[myHome.selectedRoom].gridCell[27] = false
          myHome.rooms[myHome.selectedRoom].gridCell[28] = myHome.rooms[myHome.selectedRoom].gridCell[29]
          myHome.rooms[myHome.selectedRoom].gridCell[29] = myHome.rooms[myHome.selectedRoom].gridCell[30]
          myHome.rooms[myHome.selectedRoom].gridCell[30] = myHome.rooms[myHome.selectedRoom].gridCell[31]
          myHome.rooms[myHome.selectedRoom].gridCell[31] = myHome.rooms[myHome.selectedRoom].gridCell[32]
          myHome.rooms[myHome.selectedRoom].gridCell[32] = myHome.rooms[myHome.selectedRoom].gridCell[33]
          myHome.rooms[myHome.selectedRoom].gridCell[33] = myHome.rooms[myHome.selectedRoom].gridCell[34]
          myHome.rooms[myHome.selectedRoom].gridCell[34] = false
          myHome.rooms[myHome.selectedRoom].gridCell[35] = myHome.rooms[myHome.selectedRoom].gridCell[36]
          myHome.rooms[myHome.selectedRoom].gridCell[36] = myHome.rooms[myHome.selectedRoom].gridCell[37]
          myHome.rooms[myHome.selectedRoom].gridCell[37] = myHome.rooms[myHome.selectedRoom].gridCell[38]
          myHome.rooms[myHome.selectedRoom].gridCell[38] = myHome.rooms[myHome.selectedRoom].gridCell[39]
          myHome.rooms[myHome.selectedRoom].gridCell[39] = myHome.rooms[myHome.selectedRoom].gridCell[40]
          myHome.rooms[myHome.selectedRoom].gridCell[40] = myHome.rooms[myHome.selectedRoom].gridCell[41]
          myHome.rooms[myHome.selectedRoom].gridCell[41] = false
          myHome.rooms[myHome.selectedRoom].gridCell[42] = myHome.rooms[myHome.selectedRoom].gridCell[43]
          myHome.rooms[myHome.selectedRoom].gridCell[43] = myHome.rooms[myHome.selectedRoom].gridCell[44]
          myHome.rooms[myHome.selectedRoom].gridCell[44] = myHome.rooms[myHome.selectedRoom].gridCell[45]
          myHome.rooms[myHome.selectedRoom].gridCell[45] = myHome.rooms[myHome.selectedRoom].gridCell[46]
          myHome.rooms[myHome.selectedRoom].gridCell[46] = myHome.rooms[myHome.selectedRoom].gridCell[47]
          myHome.rooms[myHome.selectedRoom].gridCell[47] = myHome.rooms[myHome.selectedRoom].gridCell[48]
          myHome.rooms[myHome.selectedRoom].gridCell[48] = false
        }
        
        
        
        while myHome.rooms[myHome.selectedRoom].countGridAxisY[0] == 0 {
          myHome.rooms[myHome.selectedRoom].countGridAxisY[0] = myHome.rooms[myHome.selectedRoom].countGridAxisY[1]
          myHome.rooms[myHome.selectedRoom].countGridAxisY[1] = myHome.rooms[myHome.selectedRoom].countGridAxisY[2]
          myHome.rooms[myHome.selectedRoom].countGridAxisY[2] = myHome.rooms[myHome.selectedRoom].countGridAxisY[3]
          myHome.rooms[myHome.selectedRoom].countGridAxisY[3] = myHome.rooms[myHome.selectedRoom].countGridAxisY[4]
          myHome.rooms[myHome.selectedRoom].countGridAxisY[4] = myHome.rooms[myHome.selectedRoom].countGridAxisY[5]
          myHome.rooms[myHome.selectedRoom].countGridAxisY[5] = myHome.rooms[myHome.selectedRoom].countGridAxisY[6]
          myHome.rooms[myHome.selectedRoom].countGridAxisY[6] = 0
          debug.console(message: "myHome.rooms[myHome.selectedRoom].countGridAxisY = \(myHome.rooms[myHome.selectedRoom].countGridAxisY)", file: #file, function: #function, line: #line)
          myHome.rooms[myHome.selectedRoom].gridCell[0] = myHome.rooms[myHome.selectedRoom].gridCell[7]
          myHome.rooms[myHome.selectedRoom].gridCell[7] = myHome.rooms[myHome.selectedRoom].gridCell[14]
          myHome.rooms[myHome.selectedRoom].gridCell[14] = myHome.rooms[myHome.selectedRoom].gridCell[21]
          myHome.rooms[myHome.selectedRoom].gridCell[21] = myHome.rooms[myHome.selectedRoom].gridCell[28]
          myHome.rooms[myHome.selectedRoom].gridCell[28] = myHome.rooms[myHome.selectedRoom].gridCell[35]
          myHome.rooms[myHome.selectedRoom].gridCell[35] = myHome.rooms[myHome.selectedRoom].gridCell[42]
          myHome.rooms[myHome.selectedRoom].gridCell[42] = false
          myHome.rooms[myHome.selectedRoom].gridCell[1] = myHome.rooms[myHome.selectedRoom].gridCell[8]
          myHome.rooms[myHome.selectedRoom].gridCell[8] = myHome.rooms[myHome.selectedRoom].gridCell[15]
          myHome.rooms[myHome.selectedRoom].gridCell[15] = myHome.rooms[myHome.selectedRoom].gridCell[22]
          myHome.rooms[myHome.selectedRoom].gridCell[22] = myHome.rooms[myHome.selectedRoom].gridCell[29]
          myHome.rooms[myHome.selectedRoom].gridCell[29] = myHome.rooms[myHome.selectedRoom].gridCell[36]
          myHome.rooms[myHome.selectedRoom].gridCell[36] = myHome.rooms[myHome.selectedRoom].gridCell[43]
          myHome.rooms[myHome.selectedRoom].gridCell[43] = false
          myHome.rooms[myHome.selectedRoom].gridCell[2] = myHome.rooms[myHome.selectedRoom].gridCell[9]
          myHome.rooms[myHome.selectedRoom].gridCell[9] = myHome.rooms[myHome.selectedRoom].gridCell[16]
          myHome.rooms[myHome.selectedRoom].gridCell[16] = myHome.rooms[myHome.selectedRoom].gridCell[23]
          myHome.rooms[myHome.selectedRoom].gridCell[23] = myHome.rooms[myHome.selectedRoom].gridCell[30]
          myHome.rooms[myHome.selectedRoom].gridCell[30] = myHome.rooms[myHome.selectedRoom].gridCell[37]
          myHome.rooms[myHome.selectedRoom].gridCell[37] = myHome.rooms[myHome.selectedRoom].gridCell[44]
          myHome.rooms[myHome.selectedRoom].gridCell[44] = false
          myHome.rooms[myHome.selectedRoom].gridCell[3] = myHome.rooms[myHome.selectedRoom].gridCell[10]
          myHome.rooms[myHome.selectedRoom].gridCell[10] = myHome.rooms[myHome.selectedRoom].gridCell[17]
          myHome.rooms[myHome.selectedRoom].gridCell[17] = myHome.rooms[myHome.selectedRoom].gridCell[24]
          myHome.rooms[myHome.selectedRoom].gridCell[24] = myHome.rooms[myHome.selectedRoom].gridCell[31]
          myHome.rooms[myHome.selectedRoom].gridCell[31] = myHome.rooms[myHome.selectedRoom].gridCell[38]
          myHome.rooms[myHome.selectedRoom].gridCell[38] = myHome.rooms[myHome.selectedRoom].gridCell[45]
          myHome.rooms[myHome.selectedRoom].gridCell[45] = false
          myHome.rooms[myHome.selectedRoom].gridCell[4] = myHome.rooms[myHome.selectedRoom].gridCell[11]
          myHome.rooms[myHome.selectedRoom].gridCell[11] = myHome.rooms[myHome.selectedRoom].gridCell[18]
          myHome.rooms[myHome.selectedRoom].gridCell[18] = myHome.rooms[myHome.selectedRoom].gridCell[25]
          myHome.rooms[myHome.selectedRoom].gridCell[25] = myHome.rooms[myHome.selectedRoom].gridCell[32]
          myHome.rooms[myHome.selectedRoom].gridCell[32] = myHome.rooms[myHome.selectedRoom].gridCell[39]
          myHome.rooms[myHome.selectedRoom].gridCell[39] = myHome.rooms[myHome.selectedRoom].gridCell[46]
          myHome.rooms[myHome.selectedRoom].gridCell[46] = false
          myHome.rooms[myHome.selectedRoom].gridCell[5] = myHome.rooms[myHome.selectedRoom].gridCell[12]
          myHome.rooms[myHome.selectedRoom].gridCell[12] = myHome.rooms[myHome.selectedRoom].gridCell[19]
          myHome.rooms[myHome.selectedRoom].gridCell[19] = myHome.rooms[myHome.selectedRoom].gridCell[26]
          myHome.rooms[myHome.selectedRoom].gridCell[26] = myHome.rooms[myHome.selectedRoom].gridCell[33]
          myHome.rooms[myHome.selectedRoom].gridCell[33] = myHome.rooms[myHome.selectedRoom].gridCell[40]
          myHome.rooms[myHome.selectedRoom].gridCell[40] = myHome.rooms[myHome.selectedRoom].gridCell[47]
          myHome.rooms[myHome.selectedRoom].gridCell[47] = false
          myHome.rooms[myHome.selectedRoom].gridCell[6] = myHome.rooms[myHome.selectedRoom].gridCell[13]
          myHome.rooms[myHome.selectedRoom].gridCell[13] = myHome.rooms[myHome.selectedRoom].gridCell[20]
          myHome.rooms[myHome.selectedRoom].gridCell[20] = myHome.rooms[myHome.selectedRoom].gridCell[27]
          myHome.rooms[myHome.selectedRoom].gridCell[27] = myHome.rooms[myHome.selectedRoom].gridCell[34]
          myHome.rooms[myHome.selectedRoom].gridCell[34] = myHome.rooms[myHome.selectedRoom].gridCell[41]
          myHome.rooms[myHome.selectedRoom].gridCell[41] = myHome.rooms[myHome.selectedRoom].gridCell[48]
          myHome.rooms[myHome.selectedRoom].gridCell[48] = false
        }
        
//        myHome.rooms[myHome.selectedRoom].emptyRowX = 6
//        myHome.rooms[myHome.selectedRoom].countGridAxisY[6] = 0
//
//        while
        
        var minimumIndex = myHome.rooms[myHome.selectedRoom].gridCell.count
        for index in 0 ..< myHome.rooms[myHome.selectedRoom].gridCell.count {
          if myHome.rooms[myHome.selectedRoom].gridCell[index] {
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
            if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Left
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              nextPoint = Point(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            }
          case .Left:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = Point(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = Point(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            }
          case .Right:
            if  (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = Point(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = Point(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            }
          case .Half:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              corner.append(Point(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = Point(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myHome.rooms[myHome.selectedRoom].gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
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
  
  //  var currentCellIsCollored = Array(repeating: Bool(), count: 49)
}
