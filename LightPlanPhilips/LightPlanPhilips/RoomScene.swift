//
//  RoomScene.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

//
//  GameScene.swift
//  Game
//
//  Created by Mark Aptroot on 07-11-16.
//  Copyright © 2016 Mark Aptroot. All rights reserved.
//

import SpriteKit


class RoomScene: SKScene {
  let debug = Debug() // debugger functionality
  var myHome : Home?
  var delegateRoomSizeAdjust: Bool?
  
  var roomSceneDelegate: RoomSceneDelegate?
  
  var dragDropEnabled: Bool?
  var createGroup: Bool?
  var noAction: Bool = false
  
  let dataSource = DataSource.sharedInstance
  
  var bulbCollection = [Bulb]()
  var groups: [Group] = []
  var groupCollection = [[Bulb]]()
  var selectedBulbs = [String:Bool]()
  var bulbs = [String: Bulb ]()
  var selectedNode = BulbSpriteNode()
  
  
  
  
  override func didMove(to view: SKView) {
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
    
    // get bulbs
    // get groups
    
    if let roomSceneDelegate = roomSceneDelegate {
      debug.console(message: "start", file: #file, function: #function, line: #line)
      bulbCollection = roomSceneDelegate.getBulbs()
    }
    //    bulbCollection = (roomSceneDelegate?.getBulbs())!
    
    groups = (roomSceneDelegate?.getGroups())!
    
    //place bulbs
    for bulb in bulbCollection {
      // create sprite with type image and type
      
      
      let sprite: BulbSpriteNode
      if bulb.lightTypeName == nil {
        sprite = BulbSpriteNode(type:NodeType.bulb, id: bulb.id)
      } else {
        sprite = BulbSpriteNode(lightTypeIcon: bulb.lightTypeIcon!, type: NodeType.bulb, id: bulb.id)
      }
    
      sprite.position = CGPoint(x: CGFloat(bulb.positionX), y: CGFloat(bulb.positionY))
      sprite.setScale(1.5)
      sprite.name = bulb.name
      selectedBulbs[bulb.id] = false
      self.addChild(sprite)
    }
    
    // place groups
    for group in groups {
      //let sprite = BulbSpriteNode(type: NodeType.group, id: group.id)
      let sprite = BulbSpriteNode(lightTypeIcon: group.groupTypeIcon!, type: NodeType.group, id: group.id)
      sprite.position = CGPoint(x: CGFloat(group.positionX!), y: CGFloat(group.positionY!))
      sprite.setScale(1.5)
      sprite.name = group.name
      
      self.addChild(sprite)
      
      
      let shape = SKShapeNode()
      shape.path = UIBezierPath(roundedRect: CGRect(x: -15, y: -15 , width: 30, height: 30), cornerRadius: 15).cgPath
      shape.position = CGPoint(x: frame.midX, y: frame.midY)
      shape.fillColor = UIColor.yellow
      shape.strokeColor = UIColor.black
      shape.lineWidth = 2
      
      
      sprite.addChild(shape)
      
      
      
      shape.position = CGPoint(x: 15, y:  -15)
      
    
      
      let groupNumber: String = String(group.assignedBulbs.count)
      
      let label = SKLabelNode(text: groupNumber)
      label.fontColor = UIColor.black
      label.fontName = "HelveticaNeue-Bold"
      label.fontSize = 24
      label.verticalAlignmentMode = .center

    
      
      shape.addChild(label)
      
      
      
    }
    
  }
  
  
  
  
  
  
  var movableNode : SKNode?
  var lastLocationInRoom: CGPoint?
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    debug.console(message: "start", file: #file, function: #function, line: #line)
    
    if let touch = touches.first {
      let location = touch.location(in: self)
      let touchedNodes = self.nodes(at: location)
      
      for node in touchedNodes {
        if node is BulbSpriteNode {
          if dragDropEnabled! {
            // move bulb
            movableNode = node
            movableNode!.position = location
          } else {
            if createGroup! {
              
              let bulbNode = node as! BulbSpriteNode
              
              // check if bulb has been selected
              if selectedBulbs[bulbNode.id] == false {
                
                // add blinking animation
                let expandAction = SKAction.scale(to: 2, duration: 0.33)
                let contractAction = SKAction.scale(to: 1.5, duration: 0.33)
                let pulsateAction = SKAction.repeatForever(SKAction.sequence([expandAction, contractAction]))
                node.run(pulsateAction)
                
                // add bulb to collection of selected bulbs
                selectedBulbs[bulbNode.id] = true
              } else {
                // remove blinking animation
                node.removeAllActions()
                let restoreScaleAcction = SKAction.scale(to: 1.5, duration: 0.1)
                node.run(restoreScaleAcction)
                
                // remove bulb from collection of selected bulbs
                bulbs.removeValue(forKey: node.name!)
                selectedBulbs[bulbNode.id] = false
              }
              
              // check if we have group (at least two selected)
              if checkIfGroup() {
                var groupBulbs = [Bulb]()
                for bulb in bulbCollection {
                  if selectedBulbs[bulb.id] == true {
                    groupBulbs.append(bulb)
                  }
                }
                
                roomSceneDelegate?.selectedBulbs(bulbs: groupBulbs)
                roomSceneDelegate?.groupSelected(groupSelected: true)
              } else {
                roomSceneDelegate?.groupSelected(groupSelected: false)
              }
            } else {
              if noAction {
                print("no action on touch")
              } else {
                let bulbNode = node as! BulbSpriteNode
                if bulbNode.type == NodeType.bulb {
                  
                  
                  roomSceneDelegate?.clickBulb(id: bulbNode.id, segue: "NameBulb")
                  
                  
                  
                } else {
                  roomSceneDelegate?.clickBulb(id: bulbNode.id, segue: "ShowGroup")
                }
              }
            }
          }
        }
      }
    }
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
  

  func placeBulb(bulb: Bulb){
  
      let sprite: BulbSpriteNode

      sprite = BulbSpriteNode(lightTypeIcon: bulb.lightTypeIcon!, type: NodeType.bulb, id: bulb.id)
      sprite.position = CGPoint(x: CGFloat(bulb.positionX), y: CGFloat(bulb.positionY))
      sprite.setScale(1.5)
      sprite.name = bulb.name
      selectedBulbs[bulb.id] = false
      self.addChild(sprite)
      bulbCollection.append(bulb)
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
