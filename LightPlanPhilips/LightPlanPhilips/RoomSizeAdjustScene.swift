//
//  RoomSizeAdjustScene.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 25-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import SpriteKit


class RoomSizeAdjustScene: SKScene {
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
  
  var bulbCollection = [Bulb]()
  var groups: [Group] = []
  var groupCollection = [[Bulb]]()
  var selectedBulbs = [String:Bool]()
  var bulbs = [String: Bulb ]()
  
  //  let bulbSprite = bulbSpriteNode(imageName: "Bulb")
  //  let groupSprite = bulbSpriteNode(imageNamed: "Bulb group")
  //  var selectedNode = bulbSpriteNode()
  
  
  
  override func didMove(to view: SKView) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    delegateRoomSizeAdjust = true
    if let delegateRoomSizeAdjust = delegateRoomSizeAdjust {
      debug.console(message: "delegateRoomSizeAdjust", file: #file, function: #function, line: #line)
      if delegateRoomSizeAdjust {
        debug.console(message: "delegateRoomSizeAdjust = \(delegateRoomSizeAdjust)", file: #file, function: #function, line: #line)
        view.backgroundColor = UIColor.white
//        var edge = DataLightPlan.sharedInstance.edge
        var edge : [Point] = []

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
            var firstPoint: Point
            var secondPoint: Point
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
            //            shape.strokeColor = UIColor.black
            //            shape.lineWidth = 2
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
    // get bulbs
    // get groups
    
    if let roomSceneDelegate = roomSceneDelegate {
      debug.console(message: "start", file: #file, function: #function, line: #line)
      bulbCollection = roomSceneDelegate.getBulbs()
    }
    //    bulbCollection = (roomSceneDelegate?.getBulbs())!
    
    //    groups = (roomSceneDelegate?.getGroups())!
    
    //place bulbs
    //    for bulb in bulbCollection {
    //      let sprite = bulbSprite.copy() as! bulbSpriteNode
    //      sprite.type = "bulb"
    //      sprite.position = CGPoint(x: CGFloat(bulb.positionX!), y: CGFloat(bulb.positionY!))
    //      sprite.setScale(1.5)
    //      sprite.name = bulb.name
    //      selectedBulbs[bulb.name] = false
    //      self.addChild(sprite)
    //    }
    
    // place groups
    //    for group in groups {
    //      let sprite = groupSprite.copy() as! bulbSpriteNode
    //      sprite.type = "group"
    //      sprite.position = CGPoint(x: CGFloat(group.positionX!), y: CGFloat(group.positionY!))
    //      sprite.setScale(1.5)
    //      sprite.name = group.name
    //
    //      self.addChild(sprite)
  }
  
  
  
  var movableNode : SKNode?
  var lastLocationInRoom: CGPoint?
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    
//    if let touch = touches.first {
//      let location = touch.location(in: self)
//      let touchedNodes = self.nodes(at: location)
      
//      for node in touchedNodes {
//        if node is bulbSpriteNode {
//          if dragDropEnabled {
//            // move bulb
//            movableNode = node
//            movableNode!.position = location
//          } else {
//            if createGroup {
//              // check if bulb has been selected
//              if selectedBulbs[node.name!]! == false {
//                
//                // add blinking animation
//                let expandAction = SKAction.scale(to: 2, duration: 0.33)
//                let contractAction = SKAction.scale(to: 1.5, duration: 0.33)
//                let pulsateAction = SKAction.repeatForever(SKAction.sequence([expandAction, contractAction]))
//                node.run(pulsateAction)
//                
//                // add bulb to collection of selected bulbs
//                selectedBulbs[node.name!]! = true
//              } else {
//                // remove blinking animation
//                node.removeAllActions()
//                let restoreScaleAcction = SKAction.scale(to: 1.5, duration: 0.1)
//                node.run(restoreScaleAcction)
//                
//                // remove bulb from collection of selected bulbs
//                bulbs.removeValue(forKey: node.name!)
//                selectedBulbs[node.name!]! = false
//              }
//              
//              // check if we have group (at least two selected)
//              if checkIfGroup() {
//                var groupBulbs = [Bulb]()
//                for bulb in bulbCollection {
//                  if selectedBulbs[bulb.name] == true {
//                    groupBulbs.append(bulb)
//                  }
//                }
//                
//                roomSceneDelegate?.selectedBulbs(bulbs: groupBulbs)
//                roomSceneDelegate?.groupSelected(groupSelected: true)
//              } else {
//                roomSceneDelegate?.groupSelected(groupSelected: false)
//              }
//            } else {
//              let bulbNode = node as! bulbSpriteNode
//              if bulbNode.type == "bulb" {
//                print("een enkele lamp")
//                roomSceneDelegate?.clickBulb(bulbName: node.name!)
//                
//                
//                // segue NameLightSegue
//                //performSegue(withIdentifier: "§", sender: nil)
//                
//              } else {
//                print("een groep")
//              }
//            }
//          }
//        }
//      }
//    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if let touch = touches.first, movableNode != nil {
      let location = touch.location(in: self)
      
      let touchedNodes = self.nodes(at: location)
      
      for node in touchedNodes {
        if node is SKShapeNode {
          lastLocationInRoom = location
          movableNode!.position = location
        }
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if let touch = touches.first, movableNode != nil {
      
      let location = touch.location(in: self)
      let touchedNodes = self.nodes(at: location)
      var endedInRoom: Bool = false
      
      
      for node in touchedNodes {
        if node is SKShapeNode {
          endedInRoom = true
          lastLocationInRoom = location
        }
      }
      
      if endedInRoom {
        movableNode!.position = location
      } else {
        movableNode!.position = lastLocationInRoom!
      }
      movableNode = nil
    }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    if touches.first != nil {
      movableNode = nil
    }
  }
  
  
  
  
  
  
  
  func checkIfGroup() -> Bool{
    debug.console(message: "start", file: #file, function: #function, line: #line)
    var counter: Int = 0
    
    for bulb in selectedBulbs {
      if bulb.value == true {
        counter += 1
      }
    }
    if counter >= 2 {
      return true
    } else {
      return false
    }
  }
  
  
  
  
  func createNewGroup() {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    
    let group = [Bulb]()
    
    self.groupCollection.append(group)
    
    createGroup = true
    
  }
  
}
