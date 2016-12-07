import SpriteKit

class RoomSizeAdjustScene: SKScene {
  let debug = Debug() // debugger functionality
  
  var myHome : Home?
  
  let roomShapeModel = RoomShapeModel()
  
  override func didMove(to view: SKView) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    var edge : [Room.Point] = []
    if let myHome = myHome {
      debug.console(message: "start", file: #file, function: #function, line: #line)
      edge = myHome.rooms[myHome.selectedRoom].edge
      debug.console(message: "edge.count = \(edge.count)", file: #file, function: #function, line: #line)
    }
    
    if edge.count != 0 {
      debug.console(message: "edge.count = \(edge.count)", file: #file, function: #function, line: #line)
      let shape = UIBezierPath()
      let multiplyEdge2NodePoint = 86
      let offsetNodePoint = 45
      let buttonBoundary = 7
      let offsetEdge2NodePoint = 3
      shape.move(to: CGPoint(x: ((edge[0].x - offsetEdge2NodePoint) * multiplyEdge2NodePoint) - offsetNodePoint,
                             y: (((buttonBoundary - edge[0].y) - offsetEdge2NodePoint) * multiplyEdge2NodePoint) - offsetNodePoint))
      debug.console(message: "(x,y) = (\(((edge[0].x - offsetEdge2NodePoint) * multiplyEdge2NodePoint) - offsetNodePoint),\((((buttonBoundary - edge[0].y) - offsetEdge2NodePoint) * multiplyEdge2NodePoint) - offsetNodePoint))", file: #file, function: #function, line: #line)
      for point in edge {
        shape.addLine(to: CGPoint(x: ((point.x - offsetEdge2NodePoint) * multiplyEdge2NodePoint) - offsetNodePoint,
                                  y: (((buttonBoundary - point.y) - offsetEdge2NodePoint) * multiplyEdge2NodePoint) - offsetNodePoint))
        debug.console(message: "(x,y) = (\(((point.x - 3) * multiplyEdge2NodePoint) - offsetNodePoint),\((((buttonBoundary - point.y) - offsetEdge2NodePoint) * multiplyEdge2NodePoint) - offsetNodePoint))", file: #file, function: #function, line: #line)
      }
      shape.close()
      let shapeTrack = SKShapeNode(path: shape.cgPath, centered: false)
      shapeTrack.position = CGPoint(x: 0, y: 50)
      shapeTrack.strokeColor = UIColor.black
      shapeTrack.lineWidth = 4
      shapeTrack.fillColor = UIColor.gray
      self.addChild(shapeTrack)
      var midX = 0.0
      var midY = 0.0
      for index in 0 ..< edge.count {
        var firstPoint: Room.Point
        var secondPoint: Room.Point
        if index == 0 {
          firstPoint = edge[index]
          secondPoint = edge[edge.count - 1]
        } else {
          firstPoint = edge[index]
          secondPoint = edge[index - 1]
        }
        let averageX = Double(firstPoint.x + secondPoint.x) / 2.0
        let averageY = Double((buttonBoundary - firstPoint.y) + (buttonBoundary - secondPoint.y)) / 2.0
        midX = (averageX - Double(offsetEdge2NodePoint)) * Double(multiplyEdge2NodePoint) - Double(offsetNodePoint)
        midY = (averageY - Double(offsetEdge2NodePoint)) * Double(multiplyEdge2NodePoint) - Double(offsetNodePoint)
        debug.console(message: "midX = \(midX), midY = \(midY)", file: #file, function: #function, line: #line)
        
        processSizeNode(CGPoint(x: midX, y: midY))
      }
    }
  }
  
  private func processSizeNode(_ position: CGPoint) {
    processSizeNodeCircle( position)
    processSizeNodeText( position)
  }
  
  private func processSizeNodeText(_ position: CGPoint) {
    let label = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
    label.text = "?"
    label.fontSize = 20
    label.fontColor = SKColor.white
    label.position = CGPoint(x: position.x, y: position.y + 40)
    self.addChild(label)
  }
  
  private func processSizeNodeCircle(_ position: CGPoint) {
    let shape = SKShapeNode()
    shape.path = UIBezierPath(roundedRect: CGRect(x: -25, y: -25 + 50, width: 50, height: 50), cornerRadius: 50).cgPath
    shape.position = position
    shape.fillColor = UIColor.black
    addChild(shape)
  }
  
  var movableNode : SKNode?
  var lastLocationInRoom: CGPoint?
  var sizeTextField : UITextField?
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
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
    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
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

