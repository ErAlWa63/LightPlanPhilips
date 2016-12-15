import SpriteKit

class RoomSizeAdjustScene: SKScene {
  var myHome : Home?
  let roomShapeModel = RoomShapeModel()
  var indexLabel = 0
  
  override func didMove(to view: SKView) {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      myRoom.spritekitCorners = generateSpritekitCorners( myRoom.gridCorners.count)
      myRoom.spritekitTextSize = generateSpritekitTextSize( myRoom.gridCorners.count)
      myRoom.spritekitCircleSize = generateSpritekitCircleSize( myRoom.gridCorners.count)
      myRoom.spritekitRealCorners = generateSpritekitRealCorners( myRoom.gridCorners.count)
      var usedColumnsX = 0
      for column in myRoom.countGridAxisXOptimized {
        if column > 0 {
          usedColumnsX += 1
        }
      }
      var usedRowsY = 0
      for row in myRoom.countGridAxisYOptimized {
        if row > 0 {
          usedRowsY += 1
        }
      }
      var scale : Double = 0
      if usedColumnsX < usedRowsY {
        scale = 7.0 / Double(usedRowsY)
      } else {
        scale = 7.0 / Double(usedColumnsX)
      }
      let multiplyEdge2NodePoint: Double = 85.714285
      let offsetEdge2NodePoint: Double = 3.5
      var coordinateX = 0
      var coordinateY = 0
      var coordinateXNext = 0
      var coordinateYNext = 0
      for index in 0 ..< myRoom.gridCorners.count {
        coordinateX = Int(((Double(myRoom.gridCorners[index].x) * scale) - offsetEdge2NodePoint) * multiplyEdge2NodePoint)
        coordinateY = Int((offsetEdge2NodePoint - (Double(myRoom.gridCorners[index].y) * scale)) * multiplyEdge2NodePoint)
        myRoom.spritekitCorners[index] = SpriteKitPoint(x: coordinateX, y: coordinateY)
      }
      let roomBoundary = UIBezierPath()
      coordinateX = myRoom.spritekitCorners[myRoom.spritekitCorners.count - 1].x
      coordinateY = myRoom.spritekitCorners[myRoom.spritekitCorners.count - 1].y
      roomBoundary.move(to: CGPoint(x: coordinateX, y: coordinateY))
      for index in 0 ..< myRoom.spritekitCorners.count - 1 {
        coordinateX = myRoom.spritekitCorners[index].x
        coordinateY = myRoom.spritekitCorners[index].y
        myRoom.spritekitCorners[index] = SpriteKitPoint(x: coordinateX, y: coordinateY)
        roomBoundary.addLine(to: CGPoint(x: coordinateX, y: coordinateY))
      }
      roomBoundary.close()
      let roomShape = SKShapeNode(path: roomBoundary.cgPath, centered: false)
      roomShape.position = CGPoint(x: 0, y: 50)
      roomShape.strokeColor = UIColor.black
      roomShape.lineWidth = 4
      roomShape.fillColor = UIColor.gray
      self.addChild(roomShape)
      var midX = 0
      var midY = 0
      for index in 0 ..< myRoom.spritekitCorners.count - 1 {
        coordinateX = myRoom.spritekitCorners[index].x
        coordinateY = myRoom.spritekitCorners[index].y
        coordinateXNext = myRoom.spritekitCorners[index + 1].x
        coordinateYNext = myRoom.spritekitCorners[index + 1].y
        midX = (coordinateX + coordinateXNext) / 2
        midY = (coordinateY + coordinateYNext) / 2
        myRoom.spritekitCircleSize[index].position = CGPoint(x: midX, y: midY)
        self.addChild(myRoom.spritekitCircleSize[index])
        myRoom.spritekitTextSize[index].position = CGPoint(x: midX, y: midY + 43)
        self.addChild(myRoom.spritekitTextSize[index])
      }
      coordinateX = myRoom.spritekitCorners[myRoom.spritekitCorners.count - 1].x
      coordinateY = myRoom.spritekitCorners[myRoom.spritekitCorners.count - 1].y
      coordinateXNext = myRoom.spritekitCorners[0].x
      coordinateYNext = myRoom.spritekitCorners[0].y
      midX = (coordinateX + coordinateXNext) / 2
      midY = (coordinateY + coordinateYNext) / 2
      myRoom.spritekitCircleSize[myRoom.spritekitCorners.count - 1].position = CGPoint(x: midX, y: midY)
      self.addChild(myRoom.spritekitCircleSize[myRoom.spritekitCorners.count - 1])
      myRoom.spritekitTextSize[myRoom.spritekitCorners.count - 1].position = CGPoint(x: midX, y: midY + 43)
      self.addChild(myRoom.spritekitTextSize[myRoom.spritekitCorners.count - 1])
    }
  }
  
  private func generateSpritekitCorners( _ size: Int) -> [SpriteKitPoint] {
    var spritekitCorners : [SpriteKitPoint] = []
    for _ in 0 ..< size {
      spritekitCorners.append(SpriteKitPoint( x: 0, y: 0))
    }
    return spritekitCorners
  }
  
  private func generateSpritekitTextSize( _ size: Int) -> [SKLabelNode] {
    var spritekitTextSize : [SKLabelNode] = []
    for index in 0 ..< size {
      let textSize = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
      textSize.text = "?"
      textSize.fontSize = 16
      textSize.fontColor = SKColor.white
      textSize.position = CGPoint(x: 0, y: 0)
      textSize.name = "\(index)"
      spritekitTextSize.append(textSize)
    }
    return spritekitTextSize
  }
  
  private func generateSpritekitCircleSize( _ size: Int) -> [SKShapeNode] {
    var spritekitCircleSize : [SKShapeNode] = []
    for _ in 0 ..< size {
      let circleSize = SKShapeNode()
      circleSize.path = UIBezierPath(roundedRect: CGRect(x: -25, y: 25, width: 50, height: 50), cornerRadius: 50).cgPath
      circleSize.position = CGPoint(x: 0, y: 0)
      circleSize.fillColor = UIColor.black
      spritekitCircleSize.append(circleSize)
    }
    return spritekitCircleSize
  }
  
  private func generateSpritekitRealCorners( _ size: Int) -> [SpriteKitPoint] {
    var spritekitRealCorners : [SpriteKitPoint] = []
    for _ in 0 ..< size {
      spritekitRealCorners.append(SpriteKitPoint( x: 0, y: 0))
    }
    return spritekitRealCorners
  }
  
  private func showSizeNode(_ position: CGPoint) {
    showCircleSizeSKShapeNode( position)
    showTextSizeSKLabelNode( position, "?")
  }
  
  private func showCircleSizeSKShapeNode(_ position: CGPoint) {
    let circleSize = SKShapeNode()
    circleSize.path = UIBezierPath(roundedRect: CGRect(x: -25, y: -25 + 50, width: 50, height: 50), cornerRadius: 50).cgPath
    circleSize.position = position
    circleSize.fillColor = UIColor.black
    addChild(circleSize)
  }
  
  private func showTextSizeSKLabelNode(_ position: CGPoint, _ text: String) {
    let textSize = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
    textSize.text = text
    textSize.fontSize = 20
    textSize.fontColor = SKColor.white
    textSize.position = CGPoint(x: position.x, y: position.y + 40)
    self.addChild(textSize)
  }
  
  var movableNode : SKNode?
  var lastLocationInRoom: CGPoint?
  var sizeTextField : UITextField?
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      let touchedNodes = self.nodes(at: location)
      
      for node in touchedNodes {
        if node is SKLabelNode {
          if let myHome = myHome {
            let myRoom = myHome.rooms[myHome.selectedRoom]
            indexLabel = Int(node.name!)!
            if myRoom.spritekitSizeInput[indexLabel] == false {
              myRoom.spritekitSizeInput[indexLabel] = true
              if sizeTextField == nil {
                if let view = view {
                  sizeTextField = UITextField (frame: CGRect(x: 80, y: 430, width: 150, height: 25))
                  if let sizeTextField = sizeTextField {
                    self.backgroundColor = UIColor.white
                    sizeTextField.layer.borderWidth      = 1
                    sizeTextField.layer.borderColor      = UIColor.lightGray.cgColor
                    sizeTextField.layer.borderWidth      = 0.5
                    sizeTextField.layer.cornerRadius     = 5
                    sizeTextField.tintColor              = UIColor.black
                    sizeTextField.textColor              = UIColor.black
                    sizeTextField.placeholder            = "Size"
                    sizeTextField.backgroundColor        = UIColor.white
                    sizeTextField.autocorrectionType     = UITextAutocorrectionType.yes
                    sizeTextField.keyboardType           = UIKeyboardType.numbersAndPunctuation
                    sizeTextField.clearButtonMode        = UITextFieldViewMode.whileEditing
                    sizeTextField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
                    sizeTextField.delegate = self
                    sizeTextField.isHidden = false
                    view.addSubview(sizeTextField)
                  }
                }
              } else {
                if let sizeTextField = sizeTextField {
                  sizeTextField.text = ""
                  sizeTextField.isHidden = false
                }
              }
            }
          }
        }
      }
    }
  }
}

extension RoomSizeAdjustScene : UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.isHidden = true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let regex = try! NSRegularExpression(pattern: "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$", options: [])
    if let text = textField.text {
      let matches = regex.matches(in: text, options:[], range: NSMakeRange(0, text.characters.count))
      guard matches.count == 0
        else {
          textField.resignFirstResponder()
          if let myHome = myHome {
            let myRoom = myHome.rooms[myHome.selectedRoom]
            myRoom.spritekitTextSize[indexLabel].text = text
            myRoom.spritekitSizeValue[indexLabel] = Double( text)!
            if indexLabel % 2 == 0 {
              myRoom.spritekitSizeInputHorizontalCount += 1
              if (myRoom.spritekitSizeInputHorizontalCount + 1) * 2 == myRoom.spritekitTextSize.count {
                var step = 0
                var missingStep = 0
                var result = 0.0
                while step < myRoom.spritekitSizeValue.count {
                  if myRoom.spritekitSizeInput[step] == true {
                    result += myRoom.spritekitSizeDirection[step] == .Normal ? myRoom.spritekitSizeValue[step] : (-1 * myRoom.spritekitSizeValue[step])
                  } else {
                    missingStep = step
                  }
                  step += 2
                }
                if myRoom.spritekitSizeDirection[missingStep] == .Normal {
                  result = -1 * result
                  myRoom.spritekitTextSize[missingStep].text = String(result)
                  myRoom.spritekitSizeValue[missingStep] = result
                } else {
                  myRoom.spritekitTextSize[missingStep].text = String(result)
                  myRoom.spritekitSizeValue[missingStep] = result
                }
              }
            } else {
              myRoom.spritekitSizeInputVerticalCount += 1
              if (myRoom.spritekitSizeInputVerticalCount + 1) * 2 == myRoom.spritekitTextSize.count {
                var step = 1
                var missingStep = 0
                var result = 0.0
                while step < myRoom.spritekitSizeValue.count {
                  if myRoom.spritekitSizeInput[step] == true {
                    result += myRoom.spritekitSizeDirection[step] == .Right ? myRoom.spritekitSizeValue[step] : (-1 * myRoom.spritekitSizeValue[step])
                  } else {
                    missingStep = step
                  }
                  step += 2
                }
                if myRoom.spritekitSizeDirection[missingStep] == .Right {
                  result = -1 * result
                  myRoom.spritekitTextSize[missingStep].text = String(result)
                  myRoom.spritekitSizeValue[missingStep] = result
                } else {
                  myRoom.spritekitTextSize[missingStep].text = String(result)
                  myRoom.spritekitSizeValue[missingStep] = result
                }
              }
            }
          }
          return isTextField2DoublePossible(textField)
      }
    }
    return isTextField2DoublePossible(textField)
  }
  
  private func isTextField2DoublePossible (_ textField: UITextField) -> Bool {
    let doubleValue = Double(textField.text!)
    if doubleValue != nil && doubleValue! > 0.0 {
      return stopTextFieldEditing()
    } else {
      return false
    }
  }
  
  private func stopTextFieldEditing () -> Bool {
    if let view = view {
      view.endEditing(true)
    }
    return true
  }
  
  internal func textFieldDidBeginEditing(_ textField: UITextField) {
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return givenInputIsPartOfDouble(textField, replacementString: string)
  }
  
  private func givenInputIsPartOfDouble(_ textField: UITextField, replacementString string: String) -> Bool {
    let char = string.cString(using: String.Encoding.utf8)!
    let isBackSpace = strcmp(char, "\\b")
    if (isBackSpace == -92) {
      return true
    }
    if string.range(of: "[0-9\\.]", options: .regularExpression) == nil {
      return false
    }
    if string.range(of: ".") == nil {
      return true
    }
    if textField.text?.range(of: ".") == nil {
      return true
    }
    return false
  }
}

