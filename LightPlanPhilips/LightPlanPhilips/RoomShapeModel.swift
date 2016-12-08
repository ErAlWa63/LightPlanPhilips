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
  
  let index2GridPoint = [ GridPoint(x: 0, y: 0), GridPoint(x: 1, y: 0), GridPoint(x: 2, y: 0), GridPoint(x: 3, y: 0), GridPoint(x: 4, y: 0), GridPoint(x: 5, y: 0), GridPoint(x: 6, y: 0),
                      GridPoint(x: 0, y: 1), GridPoint(x: 1, y: 1), GridPoint(x: 2, y: 1), GridPoint(x: 3, y: 1), GridPoint(x: 4, y: 1), GridPoint(x: 5, y: 1), GridPoint(x: 6, y: 1),
                      GridPoint(x: 0, y: 2), GridPoint(x: 1, y: 2), GridPoint(x: 2, y: 2), GridPoint(x: 3, y: 2), GridPoint(x: 4, y: 2), GridPoint(x: 5, y: 2), GridPoint(x: 6, y: 2),
                      GridPoint(x: 0, y: 3), GridPoint(x: 1, y: 3), GridPoint(x: 2, y: 3), GridPoint(x: 3, y: 3), GridPoint(x: 4, y: 3), GridPoint(x: 5, y: 3), GridPoint(x: 6, y: 3),
                      GridPoint(x: 0, y: 4), GridPoint(x: 1, y: 4), GridPoint(x: 2, y: 4), GridPoint(x: 3, y: 4), GridPoint(x: 4, y: 4), GridPoint(x: 5, y: 4), GridPoint(x: 6, y: 4),
                      GridPoint(x: 0, y: 5), GridPoint(x: 1, y: 5), GridPoint(x: 2, y: 5), GridPoint(x: 3, y: 5), GridPoint(x: 4, y: 5), GridPoint(x: 5, y: 5), GridPoint(x: 6, y: 5),
                      GridPoint(x: 0, y: 6), GridPoint(x: 1, y: 6), GridPoint(x: 2, y: 6), GridPoint(x: 3, y: 6), GridPoint(x: 4, y: 6), GridPoint(x: 5, y: 6), GridPoint(x: 6, y: 6)]
  
  private func allowedCorner( index: Int, angle: Angle) -> Bool {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      let currentPoint = index2GridPoint[index]
      switch angle {
      case .Normal:
        cellE  = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      case .Right:
        cellE  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      case .Half:
        cellE  = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      case .Left:
        cellE  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      }
      var sum = 0
      sum += cellE  ? 1 : 0
      sum += cellSE ? 2 : 0
      sum += cellS  ? 4 : 0
      if myRoom.gridCell[index] {
        if removeFrame4[sum] {
          myRoom.gridCell[index] = false
          myRoom.countCell -= 1
          myRoom.countGridAxisX[index2GridPoint[index].x] -= 1
          myRoom.countGridAxisY[index2GridPoint[index].y] -= 1
        }
      } else {
        if myRoom.countCell == 0 {
          myRoom.gridCell[index] = true
          myRoom.countCell += 1
          myRoom.countGridAxisX[index2GridPoint[index].x] += 1
          myRoom.countGridAxisY[index2GridPoint[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame4[sum] {
              myRoom.gridCell[index] = true
              myRoom.countCell += 1
              myRoom.countGridAxisX[index2GridPoint[index].x] += 1
              myRoom.countGridAxisY[index2GridPoint[index].y] += 1
            }
          }
        }
      }
      return myRoom.gridCell[index]
    } else {
      return false
    }
  }
  
  private func allowedSide( index: Int, angle: Angle) -> Bool {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      let currentPoint = index2GridPoint[index]
      switch angle {
      case .Normal:
        cellN  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellNE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellE  = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      case .Right:
        cellN  = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellNE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellE  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      case .Half:
        cellN  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellNE = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellE  = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      case .Left:
        cellN  = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellNE = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellE  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellSE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      }
      var sum = 0
      sum += cellN  ?  1 : 0
      sum += cellNE ?  2 : 0
      sum += cellE  ?  4 : 0
      sum += cellSE ?  8 : 0
      sum += cellS  ? 16 : 0
      if myRoom.gridCell[index] {
        if removeFrame6[sum] {
          myRoom.gridCell[index] = false
          myRoom.countCell -= 1
          myRoom.countGridAxisX[index2GridPoint[index].x] -= 1
          myRoom.countGridAxisY[index2GridPoint[index].y] -= 1
        }
      } else {
        if myRoom.countCell == 0 {
          myRoom.gridCell[index] = true
          myRoom.countCell += 1
          myRoom.countGridAxisX[index2GridPoint[index].x] += 1
          myRoom.countGridAxisY[index2GridPoint[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame6[sum] {
              myRoom.gridCell[index] = true
              myRoom.countCell += 1
              myRoom.countGridAxisX[index2GridPoint[index].x] += 1
              myRoom.countGridAxisY[index2GridPoint[index].y] += 1
            }
          }
        }
      }
      return myRoom.gridCell[index]
    } else {
      return false
    }
  }
  
  private func allowedInner( index: Int) -> Bool {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      let currentPoint = index2GridPoint[index]
      cellN  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellNE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellE  = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellSE = myRoom.gridCell[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellS  = myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellSW = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellW  = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellNW = myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      var sum = 0
      sum += cellN  ?   1 : 0
      sum += cellNE ?   2 : 0
      sum += cellE  ?   4 : 0
      sum += cellSE ?   8 : 0
      sum += cellS  ?  16 : 0
      sum += cellSW ?  32 : 0
      sum += cellW  ?  64 : 0
      sum += cellNW ? 128 : 0
      if myRoom.gridCell[index] {
        if removeFrame9[sum] {
          myRoom.gridCell[index] = false
          myRoom.countCell -= 1
          myRoom.countGridAxisX[index2GridPoint[index].x] -= 1
          myRoom.countGridAxisY[index2GridPoint[index].y] -= 1
        }
      } else {
        if myRoom.countCell == 0 {
          myRoom.gridCell[index] = true
          myRoom.countCell += 1
          myRoom.countGridAxisX[index2GridPoint[index].x] += 1
          myRoom.countGridAxisY[index2GridPoint[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame9[sum] {
              myRoom.gridCell[index] = true
              myRoom.countCell += 1
              myRoom.countGridAxisX[index2GridPoint[index].x] += 1
              myRoom.countGridAxisY[index2GridPoint[index].y] += 1
            }
          }
        }
      }
      return myRoom.gridCell[index]
    } else {
      return false
    }
  }
  
  func processNext () -> [GridPoint] {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      if myRoom.countCell == 0 {
        return []
      } else {
        
        myRoom.gridCellBackup = myRoom.gridCell
        
        debug.console(message: "myRoom.countGridAxisX = \(myRoom.countGridAxisX)", file: #file, function: #function, line: #line)
        debug.console(message: "myRoom.countGridAxisY = \(myRoom.countGridAxisY)", file: #file, function: #function, line: #line)
        
        
        while myRoom.countGridAxisX[0] == 0 {
          myRoom.countGridAxisX[0] = myRoom.countGridAxisX[1]
          myRoom.countGridAxisX[1] = myRoom.countGridAxisX[2]
          myRoom.countGridAxisX[2] = myRoom.countGridAxisX[3]
          myRoom.countGridAxisX[3] = myRoom.countGridAxisX[4]
          myRoom.countGridAxisX[4] = myRoom.countGridAxisX[5]
          myRoom.countGridAxisX[5] = myRoom.countGridAxisX[6]
          myRoom.countGridAxisX[6] = 0
          debug.console(message: "myRoom.countGridAxisX = \(myRoom.countGridAxisX)", file: #file, function: #function, line: #line)
          myRoom.gridCell[0] = myRoom.gridCell[1]
          myRoom.gridCell[1] = myRoom.gridCell[2]
          myRoom.gridCell[2] = myRoom.gridCell[3]
          myRoom.gridCell[3] = myRoom.gridCell[4]
          myRoom.gridCell[4] = myRoom.gridCell[5]
          myRoom.gridCell[5] = myRoom.gridCell[6]
          myRoom.gridCell[6] = false
          myRoom.gridCell[7] = myRoom.gridCell[8]
          myRoom.gridCell[8] = myRoom.gridCell[9]
          myRoom.gridCell[9] = myRoom.gridCell[10]
          myRoom.gridCell[10] = myRoom.gridCell[11]
          myRoom.gridCell[11] = myRoom.gridCell[12]
          myRoom.gridCell[12] = myRoom.gridCell[13]
          myRoom.gridCell[13] = false
          myRoom.gridCell[14] = myRoom.gridCell[15]
          myRoom.gridCell[15] = myRoom.gridCell[16]
          myRoom.gridCell[16] = myRoom.gridCell[17]
          myRoom.gridCell[17] = myRoom.gridCell[18]
          myRoom.gridCell[18] = myRoom.gridCell[19]
          myRoom.gridCell[19] = myRoom.gridCell[20]
          myRoom.gridCell[20] = false
          myRoom.gridCell[21] = myRoom.gridCell[22]
          myRoom.gridCell[22] = myRoom.gridCell[23]
          myRoom.gridCell[23] = myRoom.gridCell[24]
          myRoom.gridCell[24] = myRoom.gridCell[25]
          myRoom.gridCell[25] = myRoom.gridCell[26]
          myRoom.gridCell[26] = myRoom.gridCell[27]
          myRoom.gridCell[27] = false
          myRoom.gridCell[28] = myRoom.gridCell[29]
          myRoom.gridCell[29] = myRoom.gridCell[30]
          myRoom.gridCell[30] = myRoom.gridCell[31]
          myRoom.gridCell[31] = myRoom.gridCell[32]
          myRoom.gridCell[32] = myRoom.gridCell[33]
          myRoom.gridCell[33] = myRoom.gridCell[34]
          myRoom.gridCell[34] = false
          myRoom.gridCell[35] = myRoom.gridCell[36]
          myRoom.gridCell[36] = myRoom.gridCell[37]
          myRoom.gridCell[37] = myRoom.gridCell[38]
          myRoom.gridCell[38] = myRoom.gridCell[39]
          myRoom.gridCell[39] = myRoom.gridCell[40]
          myRoom.gridCell[40] = myRoom.gridCell[41]
          myRoom.gridCell[41] = false
          myRoom.gridCell[42] = myRoom.gridCell[43]
          myRoom.gridCell[43] = myRoom.gridCell[44]
          myRoom.gridCell[44] = myRoom.gridCell[45]
          myRoom.gridCell[45] = myRoom.gridCell[46]
          myRoom.gridCell[46] = myRoom.gridCell[47]
          myRoom.gridCell[47] = myRoom.gridCell[48]
          myRoom.gridCell[48] = false
        }
        
        
        
        while myRoom.countGridAxisY[0] == 0 {
          myRoom.countGridAxisY[0] = myRoom.countGridAxisY[1]
          myRoom.countGridAxisY[1] = myRoom.countGridAxisY[2]
          myRoom.countGridAxisY[2] = myRoom.countGridAxisY[3]
          myRoom.countGridAxisY[3] = myRoom.countGridAxisY[4]
          myRoom.countGridAxisY[4] = myRoom.countGridAxisY[5]
          myRoom.countGridAxisY[5] = myRoom.countGridAxisY[6]
          myRoom.countGridAxisY[6] = 0
          debug.console(message: "myRoom.countGridAxisY = \(myRoom.countGridAxisY)", file: #file, function: #function, line: #line)
          myRoom.gridCell[0] = myRoom.gridCell[7]
          myRoom.gridCell[7] = myRoom.gridCell[14]
          myRoom.gridCell[14] = myRoom.gridCell[21]
          myRoom.gridCell[21] = myRoom.gridCell[28]
          myRoom.gridCell[28] = myRoom.gridCell[35]
          myRoom.gridCell[35] = myRoom.gridCell[42]
          myRoom.gridCell[42] = false
          myRoom.gridCell[1] = myRoom.gridCell[8]
          myRoom.gridCell[8] = myRoom.gridCell[15]
          myRoom.gridCell[15] = myRoom.gridCell[22]
          myRoom.gridCell[22] = myRoom.gridCell[29]
          myRoom.gridCell[29] = myRoom.gridCell[36]
          myRoom.gridCell[36] = myRoom.gridCell[43]
          myRoom.gridCell[43] = false
          myRoom.gridCell[2] = myRoom.gridCell[9]
          myRoom.gridCell[9] = myRoom.gridCell[16]
          myRoom.gridCell[16] = myRoom.gridCell[23]
          myRoom.gridCell[23] = myRoom.gridCell[30]
          myRoom.gridCell[30] = myRoom.gridCell[37]
          myRoom.gridCell[37] = myRoom.gridCell[44]
          myRoom.gridCell[44] = false
          myRoom.gridCell[3] = myRoom.gridCell[10]
          myRoom.gridCell[10] = myRoom.gridCell[17]
          myRoom.gridCell[17] = myRoom.gridCell[24]
          myRoom.gridCell[24] = myRoom.gridCell[31]
          myRoom.gridCell[31] = myRoom.gridCell[38]
          myRoom.gridCell[38] = myRoom.gridCell[45]
          myRoom.gridCell[45] = false
          myRoom.gridCell[4] = myRoom.gridCell[11]
          myRoom.gridCell[11] = myRoom.gridCell[18]
          myRoom.gridCell[18] = myRoom.gridCell[25]
          myRoom.gridCell[25] = myRoom.gridCell[32]
          myRoom.gridCell[32] = myRoom.gridCell[39]
          myRoom.gridCell[39] = myRoom.gridCell[46]
          myRoom.gridCell[46] = false
          myRoom.gridCell[5] = myRoom.gridCell[12]
          myRoom.gridCell[12] = myRoom.gridCell[19]
          myRoom.gridCell[19] = myRoom.gridCell[26]
          myRoom.gridCell[26] = myRoom.gridCell[33]
          myRoom.gridCell[33] = myRoom.gridCell[40]
          myRoom.gridCell[40] = myRoom.gridCell[47]
          myRoom.gridCell[47] = false
          myRoom.gridCell[6] = myRoom.gridCell[13]
          myRoom.gridCell[13] = myRoom.gridCell[20]
          myRoom.gridCell[20] = myRoom.gridCell[27]
          myRoom.gridCell[27] = myRoom.gridCell[34]
          myRoom.gridCell[34] = myRoom.gridCell[41]
          myRoom.gridCell[41] = myRoom.gridCell[48]
          myRoom.gridCell[48] = false
        }
        var minimumIndex = myRoom.gridCell.count
        for index in 0 ..< myRoom.gridCell.count {
          if myRoom.gridCell[index] {
            if index < minimumIndex {
              minimumIndex = index
            }
          }
        }
        var corner = [index2GridPoint[minimumIndex]]
        var currentPoint = corner[0]
        var currentAngle : Angle = .Normal
        var nextPoint = GridPoint(x: currentPoint.x + 1, y: currentPoint.y)
        while !(corner[0].x == nextPoint.x && corner[0].y == nextPoint.y) {
          currentPoint = nextPoint
          switch currentAngle {
          case .Normal:
            if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Left
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            }
          case .Left:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = GridPoint(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = GridPoint(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            }
          case .Right:
            if  (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCell[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = GridPoint(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = GridPoint(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            }
          case .Half:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCell[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Left
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
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
}
