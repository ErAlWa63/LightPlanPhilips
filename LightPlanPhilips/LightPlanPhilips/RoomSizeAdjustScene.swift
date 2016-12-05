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
  let highScoreText = UITextField (frame: CGRect(x: 100, y: 450, width: 200, height: 20))
  var tapRecognizer : UITapGestureRecognizer?
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let view = view {
      debug.console(message: "start", file: #file, function: #function, line: #line)
      self.backgroundColor = UIColor.white
      highScoreText.center = CGPoint(x: 100, y: 400)
      highScoreText.borderStyle = UITextBorderStyle.roundedRect
      highScoreText.textColor = UIColor.black
      highScoreText.placeholder = "Size"
      highScoreText.backgroundColor = UIColor.white
      highScoreText.autocorrectionType = UITextAutocorrectionType.yes
      highScoreText.keyboardType = UIKeyboardType.decimalPad
      highScoreText.clearButtonMode = UITextFieldViewMode.whileEditing
      highScoreText.autocapitalizationType = UITextAutocapitalizationType.allCharacters
      view.addSubview(highScoreText)
      if tapRecognizer == nil {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        if let tapRecognizer = tapRecognizer {
          tapRecognizer.numberOfTapsRequired = 1
        }
      }
    }
  }
  func handleSingleTap(recognizer: UITapGestureRecognizer) {
    if let view = view {
      view.endEditing(true)
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
  //  func textFieldDidBeginEditing(_ textField: UITextField) {
  //    if let view = view {
  //      view.frame.origin.y -= 100
  //    }
  //  }
  //
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let view = view {
      view.frame.origin.y += 100
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let view = view {
      view.endEditing(true)
    }
    return false
  }
  func animateTextField(textField: UITextField, up: Bool, height: CGFloat) {
    if let view = view {
      UIView.beginAnimations("animateTextField", context: nil)
      UIView.setAnimationBeginsFromCurrentState(true)
      UIView.setAnimationDuration(0.3)
      view.frame = view.frame.offsetBy(dx: 0, dy: (up ? height - 250 : 250 - height))
      UIView.commitAnimations()
    }
  }
  
  internal func textFieldDidBeginEditing(_ textField: UITextField) {
    if let view = view {
      animateTextField(textField: textField, up: true, height: view.frame.size.height - textField.frame.origin.y - textField.frame.height - 20)
    }
  }
  
}
