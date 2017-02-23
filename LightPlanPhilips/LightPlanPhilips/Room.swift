import UIKit
import SpriteKit

class Room {
  var id: String
  var name: String
  var description: String?
  var pictogram: UIImage?
  var assignedBulbs: [Bulb] = []
  var groups: [Group] = []
  var gridCorners : [GridPoint] = []
  var gridDirections : [Int] = []
  var spritekitCorners : [SpriteKitPoint] = []
  var spritekitCircleSize : [SKShapeNode] = []
  var spritekitTextSize : [SKLabelNode] = []
  var spritekitSizeDirection : [Angle] = []
  var spritekitSizeInput : [Bool] = []
  var spritekitSizeInputHorizontalCount : Int = 0
  var spritekitSizeInputVerticalCount : Int = 0
  var spritekitSizeValue : [Double] = []
  var spritekitRealCorners : [SpriteKitPoint] = []
  var gridCellUser = Array(repeating: Bool(), count: 49)
  var gridCellOptimized = Array(repeating: Bool(), count: 49)
  var countGridAxisXUser = [0, 0, 0, 0, 0, 0, 0]
  var countGridAxisYUser = [0, 0, 0, 0, 0, 0, 0]
  var countGridAxisXOptimized : [Int] = []
  var countGridAxisYOptimized : [Int] = []
  var countCell = 0

  init(id: String, name: String) {
    self.id =  id
    self.name = name
  }
  init(id: String, name: String, file: String) {
    self.id =  id
    self.name = name
    self.pictogram   = UIImage(named: file)!
  }
  init(id: String, name: String, description: String, file: String) {
    self.id =  id
    self.name = name
    self.description = description
    self.pictogram   = UIImage(named: file)!
  }
  init(id: String, name: String, file: String, grid: [Bool]) {
    self.id =  id
    self.name = name
    self.pictogram   = UIImage(named: file)!
    self.gridCellUser = grid
  }
}
