import SpriteKit

class PlaceFurnitureScene: SKScene {
  var myHome : Home?
  
  override func didMove(to view: SKView) {
    if let myHome = myHome {
      let myRoom = myHome.rooms[myHome.selectedRoom]
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
}
