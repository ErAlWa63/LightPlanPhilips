import SpriteKit

class RoomSizeAdjustScene: SKScene {
//  let debug = Debug() // debugger functionality
  
  var myHome : Home?
  let roomShapeModel = RoomShapeModel()
  
  override func didMove(to view: SKView) {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
//      debug.console(message: "start", file: #file, function: #function, line: #line)
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
//      debug.console(message: "usedColumnsX = \(usedColumnsX)", file: #file, function: #function, line: #line)
      var usedRowsY = 0
      for row in myRoom.countGridAxisYOptimized {
        if row > 0 {
          usedRowsY += 1
        }
      }
//      debug.console(message: "usedRowsY = \(usedRowsY)", file: #file, function: #function, line: #line)
      var scale : Double = 0
      if usedColumnsX < usedRowsY {
        scale = 7.0 / Double(usedRowsY)
      } else {
        scale = 7.0 / Double(usedColumnsX)
      }
//      debug.console(message: "scale = \(scale)", file: #file, function: #function, line: #line)
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
    for _ in 0 ..< size {
      let textSize = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
      textSize.text = "?"
      textSize.fontSize = 16
      textSize.fontColor = SKColor.white
      textSize.position = CGPoint(x: 0, y: 0)
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
//    debug.console(message: "start", file: #file, function: #function, line: #line)
    if sizeTextField == nil {
      if let view = view {
        sizeTextField = UITextField (frame: CGRect(x: 100, y: 400, width: 150, height: 25))
        if let sizeTextField = sizeTextField {
          self.backgroundColor = UIColor.white
          sizeTextField.layer.borderWidth = 1
          sizeTextField.layer.borderColor  = UIColor.lightGray.cgColor
          sizeTextField.layer.borderWidth  = 0.5
          sizeTextField.layer.cornerRadius = 5
          sizeTextField.tintColor          = UIColor.black
          sizeTextField.textColor = UIColor.black
          sizeTextField.placeholder = "Size"
          sizeTextField.backgroundColor = UIColor.white
          sizeTextField.autocorrectionType = UITextAutocorrectionType.yes
          sizeTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
          sizeTextField.clearButtonMode = UITextFieldViewMode.whileEditing
          sizeTextField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
          sizeTextField.delegate = self
          sizeTextField.isHidden = false
          view.addSubview(sizeTextField)
        }
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
}

extension RoomSizeAdjustScene : UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let view = view {
      animateTextField(up: false, height: view.frame.size.height - 400)
      textField.isHidden = true
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[-+]?[0-9]*\\.?[0-9]+$", options: [])
    if let text = textField.text {
      let matches = regex.matches(in: text, options:[], range: NSMakeRange(0, text.characters.count))
      guard matches.count == 0
        else {
          textField.resignFirstResponder()
          return isTextField2DoublePossible(textField)
      }
    }
    return isTextField2DoublePossible(textField)
  }
  
  private func isTextField2DoublePossible (_ textField: UITextField) -> Bool {
    let doubleValue = Double(textField.text!)
    if doubleValue != nil {
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
  
  private func animateTextField(up: Bool, height: CGFloat) {
    if let view = view {
      UIView.beginAnimations("animateTextField", context: nil)
      UIView.setAnimationBeginsFromCurrentState(true)
      UIView.setAnimationDuration(0.5)
      view.frame = view.frame.offsetBy(dx: 0, dy: (up ? height - 250 : 250 - height))
      UIView.commitAnimations()
    }
  }
  
  internal func textFieldDidBeginEditing(_ textField: UITextField) {
    if let view = view {
      animateTextField(up: true, height: view.frame.size.height - 400)
      textField.text = ""
    }
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

