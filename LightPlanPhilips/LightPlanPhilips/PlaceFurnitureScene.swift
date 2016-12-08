import SpriteKit

class PlaceFurnitureScene: SKScene {
  let debug = Debug() // debugger functionality
  var myHome : Home?
  
  var movableNode : SKNode?
  
  override func didMove(to view: SKView) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
      debug.console(message: "start", file: #file, function: #function, line: #line)
      var coordinateX = 0
      var coordinateY = 0
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
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
}
