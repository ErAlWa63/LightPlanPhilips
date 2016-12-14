class RoomShapeModel {
  var myHome : Home?
  
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
        cellE  = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      case .Right:
        cellE  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      case .Half:
        cellE  = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      case .Left:
        cellE  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      }
      var sum = 0
      sum += cellE  ? 1 : 0
      sum += cellSE ? 2 : 0
      sum += cellS  ? 4 : 0
      if myRoom.gridCellUser[index] {
        if removeFrame4[sum] {
          myRoom.gridCellUser[index] = false
          myRoom.countCell -= 1
          myRoom.countGridAxisXUser[index2GridPoint[index].x] -= 1
          myRoom.countGridAxisYUser[index2GridPoint[index].y] -= 1
        }
      } else {
        if myRoom.countCell == 0 {
          myRoom.gridCellUser[index] = true
          myRoom.countCell += 1
          myRoom.countGridAxisXUser[index2GridPoint[index].x] += 1
          myRoom.countGridAxisYUser[index2GridPoint[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame4[sum] {
              myRoom.gridCellUser[index] = true
              myRoom.countCell += 1
              myRoom.countGridAxisXUser[index2GridPoint[index].x] += 1
              myRoom.countGridAxisYUser[index2GridPoint[index].y] += 1
            }
          }
        }
      }
      return myRoom.gridCellUser[index]
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
        cellN  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellNE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellE  = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      case .Right:
        cellN  = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
        cellNE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
        cellE  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      case .Half:
        cellN  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
        cellNE = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
        cellE  = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      case .Left:
        cellN  = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
        cellNE = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
        cellE  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
        cellSE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
        cellS  = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      }
      var sum = 0
      sum += cellN  ?  1 : 0
      sum += cellNE ?  2 : 0
      sum += cellE  ?  4 : 0
      sum += cellSE ?  8 : 0
      sum += cellS  ? 16 : 0
      if myRoom.gridCellUser[index] {
        if removeFrame6[sum] {
          myRoom.gridCellUser[index] = false
          myRoom.countCell -= 1
          myRoom.countGridAxisXUser[index2GridPoint[index].x] -= 1
          myRoom.countGridAxisYUser[index2GridPoint[index].y] -= 1
        }
      } else {
        if myRoom.countCell == 0 {
          myRoom.gridCellUser[index] = true
          myRoom.countCell += 1
          myRoom.countGridAxisXUser[index2GridPoint[index].x] += 1
          myRoom.countGridAxisYUser[index2GridPoint[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame6[sum] {
              myRoom.gridCellUser[index] = true
              myRoom.countCell += 1
              myRoom.countGridAxisXUser[index2GridPoint[index].x] += 1
              myRoom.countGridAxisYUser[index2GridPoint[index].y] += 1
            }
          }
        }
      }
      return myRoom.gridCellUser[index]
    } else {
      return false
    }
  }
  
  private func allowedInner( index: Int) -> Bool {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      let currentPoint = index2GridPoint[index]
      cellN  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)]
      cellNE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y - 1) * 7)]
      cellE  = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 0) * 7)]
      cellSE = myRoom.gridCellUser[ (currentPoint.x + 1) + ((currentPoint.y + 1) * 7)]
      cellS  = myRoom.gridCellUser[ (currentPoint.x + 0) + ((currentPoint.y + 1) * 7)]
      cellSW = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 1) * 7)]
      cellW  = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)]
      cellNW = myRoom.gridCellUser[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)]
      var sum = 0
      sum += cellN  ?   1 : 0
      sum += cellNE ?   2 : 0
      sum += cellE  ?   4 : 0
      sum += cellSE ?   8 : 0
      sum += cellS  ?  16 : 0
      sum += cellSW ?  32 : 0
      sum += cellW  ?  64 : 0
      sum += cellNW ? 128 : 0
      if myRoom.gridCellUser[index] {
        if removeFrame9[sum] {
          myRoom.gridCellUser[index] = false
          myRoom.countCell -= 1
          myRoom.countGridAxisXUser[index2GridPoint[index].x] -= 1
          myRoom.countGridAxisYUser[index2GridPoint[index].y] -= 1
        }
      } else {
        if myRoom.countCell == 0 {
          myRoom.gridCellUser[index] = true
          myRoom.countCell += 1
          myRoom.countGridAxisXUser[index2GridPoint[index].x] += 1
          myRoom.countGridAxisYUser[index2GridPoint[index].y] += 1
        } else {
          if sum != 0 {
            if addFrame9[sum] {
              myRoom.gridCellUser[index] = true
              myRoom.countCell += 1
              myRoom.countGridAxisXUser[index2GridPoint[index].x] += 1
              myRoom.countGridAxisYUser[index2GridPoint[index].y] += 1
            }
          }
        }
      }
      return myRoom.gridCellUser[index]
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
        myRoom.gridCellOptimized = myRoom.gridCellUser
        myRoom.countGridAxisXOptimized = myRoom.countGridAxisXUser
        myRoom.countGridAxisYOptimized = myRoom.countGridAxisYUser
        while myRoom.countGridAxisXOptimized[0] == 0 {
          myRoom.countGridAxisXOptimized[0] = myRoom.countGridAxisXOptimized[1]
          myRoom.countGridAxisXOptimized[1] = myRoom.countGridAxisXOptimized[2]
          myRoom.countGridAxisXOptimized[2] = myRoom.countGridAxisXOptimized[3]
          myRoom.countGridAxisXOptimized[3] = myRoom.countGridAxisXOptimized[4]
          myRoom.countGridAxisXOptimized[4] = myRoom.countGridAxisXOptimized[5]
          myRoom.countGridAxisXOptimized[5] = myRoom.countGridAxisXOptimized[6]
          myRoom.countGridAxisXOptimized[6] = 0
          myRoom.gridCellOptimized[0] = myRoom.gridCellOptimized[1]
          myRoom.gridCellOptimized[1] = myRoom.gridCellOptimized[2]
          myRoom.gridCellOptimized[2] = myRoom.gridCellOptimized[3]
          myRoom.gridCellOptimized[3] = myRoom.gridCellOptimized[4]
          myRoom.gridCellOptimized[4] = myRoom.gridCellOptimized[5]
          myRoom.gridCellOptimized[5] = myRoom.gridCellOptimized[6]
          myRoom.gridCellOptimized[6] = false
          myRoom.gridCellOptimized[7] = myRoom.gridCellOptimized[8]
          myRoom.gridCellOptimized[8] = myRoom.gridCellOptimized[9]
          myRoom.gridCellOptimized[9] = myRoom.gridCellOptimized[10]
          myRoom.gridCellOptimized[10] = myRoom.gridCellOptimized[11]
          myRoom.gridCellOptimized[11] = myRoom.gridCellOptimized[12]
          myRoom.gridCellOptimized[12] = myRoom.gridCellOptimized[13]
          myRoom.gridCellOptimized[13] = false
          myRoom.gridCellOptimized[14] = myRoom.gridCellOptimized[15]
          myRoom.gridCellOptimized[15] = myRoom.gridCellOptimized[16]
          myRoom.gridCellOptimized[16] = myRoom.gridCellOptimized[17]
          myRoom.gridCellOptimized[17] = myRoom.gridCellOptimized[18]
          myRoom.gridCellOptimized[18] = myRoom.gridCellOptimized[19]
          myRoom.gridCellOptimized[19] = myRoom.gridCellOptimized[20]
          myRoom.gridCellOptimized[20] = false
          myRoom.gridCellOptimized[21] = myRoom.gridCellOptimized[22]
          myRoom.gridCellOptimized[22] = myRoom.gridCellOptimized[23]
          myRoom.gridCellOptimized[23] = myRoom.gridCellOptimized[24]
          myRoom.gridCellOptimized[24] = myRoom.gridCellOptimized[25]
          myRoom.gridCellOptimized[25] = myRoom.gridCellOptimized[26]
          myRoom.gridCellOptimized[26] = myRoom.gridCellOptimized[27]
          myRoom.gridCellOptimized[27] = false
          myRoom.gridCellOptimized[28] = myRoom.gridCellOptimized[29]
          myRoom.gridCellOptimized[29] = myRoom.gridCellOptimized[30]
          myRoom.gridCellOptimized[30] = myRoom.gridCellOptimized[31]
          myRoom.gridCellOptimized[31] = myRoom.gridCellOptimized[32]
          myRoom.gridCellOptimized[32] = myRoom.gridCellOptimized[33]
          myRoom.gridCellOptimized[33] = myRoom.gridCellOptimized[34]
          myRoom.gridCellOptimized[34] = false
          myRoom.gridCellOptimized[35] = myRoom.gridCellOptimized[36]
          myRoom.gridCellOptimized[36] = myRoom.gridCellOptimized[37]
          myRoom.gridCellOptimized[37] = myRoom.gridCellOptimized[38]
          myRoom.gridCellOptimized[38] = myRoom.gridCellOptimized[39]
          myRoom.gridCellOptimized[39] = myRoom.gridCellOptimized[40]
          myRoom.gridCellOptimized[40] = myRoom.gridCellOptimized[41]
          myRoom.gridCellOptimized[41] = false
          myRoom.gridCellOptimized[42] = myRoom.gridCellOptimized[43]
          myRoom.gridCellOptimized[43] = myRoom.gridCellOptimized[44]
          myRoom.gridCellOptimized[44] = myRoom.gridCellOptimized[45]
          myRoom.gridCellOptimized[45] = myRoom.gridCellOptimized[46]
          myRoom.gridCellOptimized[46] = myRoom.gridCellOptimized[47]
          myRoom.gridCellOptimized[47] = myRoom.gridCellOptimized[48]
          myRoom.gridCellOptimized[48] = false
        }
        while myRoom.countGridAxisYOptimized[0] == 0 {
          myRoom.countGridAxisYOptimized[0] = myRoom.countGridAxisYOptimized[1]
          myRoom.countGridAxisYOptimized[1] = myRoom.countGridAxisYOptimized[2]
          myRoom.countGridAxisYOptimized[2] = myRoom.countGridAxisYOptimized[3]
          myRoom.countGridAxisYOptimized[3] = myRoom.countGridAxisYOptimized[4]
          myRoom.countGridAxisYOptimized[4] = myRoom.countGridAxisYOptimized[5]
          myRoom.countGridAxisYOptimized[5] = myRoom.countGridAxisYOptimized[6]
          myRoom.countGridAxisYOptimized[6] = 0
          myRoom.gridCellOptimized[0] = myRoom.gridCellOptimized[7]
          myRoom.gridCellOptimized[7] = myRoom.gridCellOptimized[14]
          myRoom.gridCellOptimized[14] = myRoom.gridCellOptimized[21]
          myRoom.gridCellOptimized[21] = myRoom.gridCellOptimized[28]
          myRoom.gridCellOptimized[28] = myRoom.gridCellOptimized[35]
          myRoom.gridCellOptimized[35] = myRoom.gridCellOptimized[42]
          myRoom.gridCellOptimized[42] = false
          myRoom.gridCellOptimized[1] = myRoom.gridCellOptimized[8]
          myRoom.gridCellOptimized[8] = myRoom.gridCellOptimized[15]
          myRoom.gridCellOptimized[15] = myRoom.gridCellOptimized[22]
          myRoom.gridCellOptimized[22] = myRoom.gridCellOptimized[29]
          myRoom.gridCellOptimized[29] = myRoom.gridCellOptimized[36]
          myRoom.gridCellOptimized[36] = myRoom.gridCellOptimized[43]
          myRoom.gridCellOptimized[43] = false
          myRoom.gridCellOptimized[2] = myRoom.gridCellOptimized[9]
          myRoom.gridCellOptimized[9] = myRoom.gridCellOptimized[16]
          myRoom.gridCellOptimized[16] = myRoom.gridCellOptimized[23]
          myRoom.gridCellOptimized[23] = myRoom.gridCellOptimized[30]
          myRoom.gridCellOptimized[30] = myRoom.gridCellOptimized[37]
          myRoom.gridCellOptimized[37] = myRoom.gridCellOptimized[44]
          myRoom.gridCellOptimized[44] = false
          myRoom.gridCellOptimized[3] = myRoom.gridCellOptimized[10]
          myRoom.gridCellOptimized[10] = myRoom.gridCellOptimized[17]
          myRoom.gridCellOptimized[17] = myRoom.gridCellOptimized[24]
          myRoom.gridCellOptimized[24] = myRoom.gridCellOptimized[31]
          myRoom.gridCellOptimized[31] = myRoom.gridCellOptimized[38]
          myRoom.gridCellOptimized[38] = myRoom.gridCellOptimized[45]
          myRoom.gridCellOptimized[45] = false
          myRoom.gridCellOptimized[4] = myRoom.gridCellOptimized[11]
          myRoom.gridCellOptimized[11] = myRoom.gridCellOptimized[18]
          myRoom.gridCellOptimized[18] = myRoom.gridCellOptimized[25]
          myRoom.gridCellOptimized[25] = myRoom.gridCellOptimized[32]
          myRoom.gridCellOptimized[32] = myRoom.gridCellOptimized[39]
          myRoom.gridCellOptimized[39] = myRoom.gridCellOptimized[46]
          myRoom.gridCellOptimized[46] = false
          myRoom.gridCellOptimized[5] = myRoom.gridCellOptimized[12]
          myRoom.gridCellOptimized[12] = myRoom.gridCellOptimized[19]
          myRoom.gridCellOptimized[19] = myRoom.gridCellOptimized[26]
          myRoom.gridCellOptimized[26] = myRoom.gridCellOptimized[33]
          myRoom.gridCellOptimized[33] = myRoom.gridCellOptimized[40]
          myRoom.gridCellOptimized[40] = myRoom.gridCellOptimized[47]
          myRoom.gridCellOptimized[47] = false
          myRoom.gridCellOptimized[6] = myRoom.gridCellOptimized[13]
          myRoom.gridCellOptimized[13] = myRoom.gridCellOptimized[20]
          myRoom.gridCellOptimized[20] = myRoom.gridCellOptimized[27]
          myRoom.gridCellOptimized[27] = myRoom.gridCellOptimized[34]
          myRoom.gridCellOptimized[34] = myRoom.gridCellOptimized[41]
          myRoom.gridCellOptimized[41] = myRoom.gridCellOptimized[48]
          myRoom.gridCellOptimized[48] = false
        }
        var minimumIndex = myRoom.gridCellOptimized.count
        for index in 0 ..< myRoom.gridCellOptimized.count {
          if myRoom.gridCellOptimized[index] {
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
            if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Left
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            }
          case .Left:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = GridPoint(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x + 0) + ((currentPoint.y - 1) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = GridPoint(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            }
          case .Right:
            if  (currentPoint.x + 0) >= 0 && (currentPoint.x + 0) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x + 0) + ((currentPoint.y + 0) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Normal
              nextPoint = GridPoint(x: (currentPoint.x + 1), y: (currentPoint.y + 0))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Half
              nextPoint = GridPoint(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            }
          case .Half:
            if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y + 0) >= 0 && (currentPoint.y + 0) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x - 1) + ((currentPoint.y + 0) * 7)] {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Right
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y + 1))
            } else if (currentPoint.x - 1) >= 0 && (currentPoint.x - 1) <= 6 && (currentPoint.y - 1) >= 0 && (currentPoint.y - 1) <= 6 && myRoom.gridCellOptimized[ (currentPoint.x - 1) + ((currentPoint.y - 1) * 7)] {
              nextPoint = GridPoint(x: (currentPoint.x - 1), y: (currentPoint.y + 0))
            } else {
              corner.append(GridPoint(x: currentPoint.x, y: currentPoint.y))
              currentAngle = .Left
              nextPoint = GridPoint(x: (currentPoint.x + 0), y: (currentPoint.y - 1))
            }
          }
        }
        return corner
      }
    } else {
      return []
    }
    
  }
}
