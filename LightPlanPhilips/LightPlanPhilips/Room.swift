import Foundation
import UIKit
import SpriteKit

struct GridPoint {
  var x: Int
  var y: Int
}

struct SpriteKitPoint {
  var x: Int
  var y: Int
}

class Room {
  var id: String
  var name: String
  var description: String?
  var pictogram: UIImage?
  var assignedBulbs: [Bulb] = []
  var groups: [Group] = []
  var gridCorners : [GridPoint] = []
  var spritekitCorners : [SpriteKitPoint] = []
  var spritekitCircleSize : [SKShapeNode] = []
  var spritekitTextSize : [SKLabelNode] = []
  var spritekitRealCorners : [SpriteKitPoint] = []
  var gridCell = Array(repeating: Bool(), count: 49)
  var gridCellBackup = Array(repeating: Bool(), count: 49)
  var countGridAxisX = [0, 0, 0, 0, 0, 0, 0]
  var countGridAxisY = [0, 0, 0, 0, 0, 0, 0]
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
    self.gridCell = grid
  }
}
