import SpriteKit

class RoomSizeAdjustScene: SKScene {
  var myHome : Home?
  
  let roomShapeModel = RoomShapeModel()
  struct Point {
    var x: Int
    var y: Int
  }
  
  let debug = Debug() // debugger functionality
  var delegateRoomSizeAdjust: Bool?
  
  var roomSceneDelegate: RoomSceneDelegate?
  
  var dragDropEnabled: Bool = false
  var createGroup: Bool = false
  
  let dataSource = DataSource.sharedInstance
  
  override func didMove(to view: SKView) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    delegateRoomSizeAdjust = true
    if let delegateRoomSizeAdjust = delegateRoomSizeAdjust {
      debug.console(message: "delegateRoomSizeAdjust", file: #file, function: #function, line: #line)
      if delegateRoomSizeAdjust {
        debug.console(message: "delegateRoomSizeAdjust = \(delegateRoomSizeAdjust)", file: #file, function: #function, line: #line)
        view.backgroundColor = UIColor.white
        var edge : [RoomShapeModel.Point] = []
        if let myHome = myHome {
          debug.console(message: "start", file: #file, function: #function, line: #line)
          edge = myHome.rooms[myHome.selectedRoom].edge
          debug.console(message: "edge.count = \(edge.count)", file: #file, function: #function, line: #line)
        }
        
        if edge.count != 0 {
          debug.console(message: "edge.count = \(edge.count)", file: #file, function: #function, line: #line)
          let shape = UIBezierPath()
          let multiplyEdge2NodePoint = 85
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
            var firstPoint: RoomShapeModel.Point
            var secondPoint: RoomShapeModel.Point
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
            
            let shape = SKShapeNode()
            shape.path = UIBezierPath(roundedRect: CGRect(x: -25, y: -25 + 50, width: 50, height: 50), cornerRadius: 50).cgPath
            shape.position = CGPoint(x: midX, y: midY)
            shape.fillColor = UIColor.black
            addChild(shape)
            let label = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
            label.text = "?"
            label.fontSize = 20
            label.fontColor = SKColor.white
            label.position = CGPoint(x: midX, y: midY + 40)
            self.addChild(label)
          }
        }
      }
    }
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
          sizeTextField.keyboardType = UIKeyboardType.default
          sizeTextField.clearButtonMode = UITextFieldViewMode.whileEditing
          sizeTextField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
          sizeTextField.delegate = self
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
    }
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let view = view {
      view.endEditing(true)
    }
    return false
  }
  func animateTextField(up: Bool, height: CGFloat) {
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
    }
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//  let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
//    if string.rangeOfCharacter(from: ".0123456789") == nil {
//      return false
//    }
    let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
    let replacementTextHasDecimalSeparator = string.range(of: ".")
    if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
      return false
    }
//    else {
//      let replacementTextHasNumber = string.range(of: "0123456789")
//      if replacementTextHasNumber
//      return true
//    }
    return true
  }
}
