//
//  RoomScene.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//


import SpriteKit


class RoomScene: SKScene {
  let debug = Debug() // debugger functionality
  
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
  
  var room: Room?
  var backupPosition: CGPoint?
  
  
  
  override func didMove(to view: SKView) {
    
    
    if let roomSceneDelegate = roomSceneDelegate {
      bulbCollection = roomSceneDelegate.getBulbs()
      groups = roomSceneDelegate.getGroups()
      room = roomSceneDelegate.getRoom()
    }
    
    
    // create room shape
    debug.console(message: "start", file: #file, function: #function, line: #line)
    var coordinateX = 0
    var coordinateY = 0
    let roomBoundary = UIBezierPath()
    coordinateX = (room?.spritekitCorners[(room?.spritekitCorners.count)! - 1].x)!
    coordinateY = (room?.spritekitCorners[(room?.spritekitCorners.count)! - 1].y)!
    roomBoundary.move(to: CGPoint(x: coordinateX, y: coordinateY))
    for index in 0 ..< (room?.spritekitCorners.count)! - 1 {
      coordinateX = (room?.spritekitCorners[index].x)!
      coordinateY = (room?.spritekitCorners[index].y)!
      room?.spritekitCorners[index] = SpriteKitPoint(x: coordinateX, y: coordinateY)
      roomBoundary.addLine(to: CGPoint(x: coordinateX, y: coordinateY))
    }
    roomBoundary.close()
    let roomShape = SKShapeNode(path: roomBoundary.cgPath, centered: false)
    roomShape.position = CGPoint(x: 0, y: 50)
    roomShape.strokeColor = UIColor.black
    roomShape.lineWidth = 4
    roomShape.fillColor = UIColor.gray
    
    roomShape.name = "room"
    self.addChild(roomShape)
    
    
    var inRoom: Bool = false
    let startLocation = CGPoint(x: 0, y: 0)
    for node in self.nodes(at:startLocation) {
      if node.name == "room" {
        if node.contains(startLocation) {
                  inRoom = true
        }
      }
    }
    
    if inRoom == false {
      // create backup position if default bulb placement location is outside room
      backupPosition = CGPoint(x: (room?.spritekitCorners[0].x)! + 15, y: (room?.spritekitCorners[0].y)! - 15)
    }
    
    
    
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
      
      // ad yellow circel shape
      let shape = SKShapeNode()
      shape.path = UIBezierPath(roundedRect: CGRect(x: -15, y: -15 , width: 30, height: 30), cornerRadius: 15).cgPath
      shape.position = CGPoint(x: frame.midX, y: frame.midY)
      shape.fillColor = UIColor.yellow
      shape.strokeColor = UIColor.black
      shape.lineWidth = 2
      sprite.addChild(shape)
      shape.position = CGPoint(x: 25, y:  -25)
      
      // ad number of bulbs in group
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
                  break
                  
                  
                } else {
                  roomSceneDelegate?.clickBulb(id: bulbNode.id, segue: "ShowGroup")
                  break
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
        if node is SKShapeNode, node.name == "room" {
          if node.contains(location){
            
            lastLocationInRoom = location
            movableNode!.position = location
            
          }
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
        if node is SKShapeNode, node.name == "room" {
            if node.contains(location){
              endedInRoom = true
              lastLocationInRoom = location
          }
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
  
  
  func placeBulb(bulb: Bulb, cell: UICollectionViewCell){
    
    let sprite: BulbSpriteNode
    
    sprite = BulbSpriteNode(lightTypeIcon: bulb.lightTypeIcon!, type: NodeType.bulb, id: bulb.id)
    
    
    let cellLocation = cell.convert(cell.center, to: self.view)
    let position = sprite.convert(cellLocation, to: self)
    
    sprite.setScale(5)
    sprite.alpha = 0
    
    

    
    
    let spriteX = position.x - (((self.scene?.frame.width)! / 2) - sprite.frame.width / 2  )
    let spriteY = position.y - (((self.scene?.frame.height)! / 2) + sprite.frame.height / 2 )
    
    sprite.position = CGPoint(x: spriteX, y: spriteY)
    
    
    
    
    
    
    sprite.name = bulb.name
    selectedBulbs[bulb.id] = false
    self.addChild(sprite)
    
    // ad a litle bit of random to the bulb position
    let randomX = Int(arc4random_uniform(UInt32(50))) - 25
    let randomY = Int(arc4random_uniform(UInt32(50))) - 25


    let endPoint = CGPoint(x: CGFloat(bulb.positionX) + CGFloat(randomX), y: CGFloat(bulb.positionY) + CGFloat(randomY))

    
    let contractAction = SKAction.scale(to: 1.5, duration: 0.75)
    let alphaAction = SKAction.fadeAlpha(to: 1, duration: 2)
    let moveAction = SKAction.move(to: endPoint, duration: 0.5)
    
    sprite.run(contractAction)
    sprite.run(moveAction)
    sprite.run(alphaAction)
    
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
