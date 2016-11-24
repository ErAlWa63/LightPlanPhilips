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
  let d = D() // debugger functionality
  
  var roomSceneDelegate: RoomSceneDelegate?
  
  var dragDropEnabled: Bool = false
  var createGroup: Bool = false
  
  let dataSource = DataSource.sharedInstance
  
  var bulbCollection = [Bulb]()
  var groups: [Group] = []
  var groupCollection = [[Bulb]]()
  var selectedBulbs = [String:Bool]()
  var bulbs = [String: Bulb ]()
  
  let bulbSprite = bulbSpriteNode(imageName: "Bulb")
  let groupSprite = bulbSpriteNode(imageNamed: "Bulb group")
  var selectedNode = bulbSpriteNode()
  
  
  
  override func didMove(to view: SKView) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
    // get bulbs
    // get groups
    
    if let roomSceneDelegate = roomSceneDelegate {
      d.c(m: "start", f: #file, fu: #function, l: #line)
      bulbCollection = roomSceneDelegate.getBulbs()
    }
    //    bulbCollection = (roomSceneDelegate?.getBulbs())!
    
    //    groups = (roomSceneDelegate?.getGroups())!
    
    //place bulbs
    for bulb in bulbCollection {
      let sprite = bulbSprite.copy() as! bulbSpriteNode
      sprite.type = "bulb"
      sprite.position = CGPoint(x: CGFloat(bulb.positionX!), y: CGFloat(bulb.positionY!))
      sprite.setScale(1.5)
      sprite.name = bulb.name
      selectedBulbs[bulb.name] = false
      self.addChild(sprite)
    }
    
    // place groups
    for group in groups {
      let sprite = groupSprite.copy() as! bulbSpriteNode
      sprite.type = "group"
      sprite.position = CGPoint(x: CGFloat(group.positionX!), y: CGFloat(group.positionY!))
      sprite.setScale(1.5)
      sprite.name = group.name
      
      self.addChild(sprite)
    }
//    let label = SKLabelNode(fontNamed: "Chalkduster")
//    label.text = "Wel opletten"
//    label.fontSize = 70
//    label.fontColor = SKColor.red
//    label.position = CGPoint(x: 0, y: 0)
//    self.addChild(label)
    d.c(m: "start", f: #file, fu: #function, l: #line)

    var edge = [Point(x: 0, y: 0),
                Point(x: 1, y: 0),
                Point(x: 1, y: 1),
                Point(x: 3, y: 1),
                Point(x: 3, y: 3),
                Point(x: 0, y: 3)
    ]
//    edge = DataLightPlan.sharedInstance.processNext()
    if edge.count != 0 {
      d.c(m: "start", f: #file, fu: #function, l: #line)
      let shape = UIBezierPath()
      let multiply = 100
      shape.move(to: CGPoint(x: edge[0].x * multiply, y: edge[0].y * multiply))
      for point in edge {
        shape.addLine(to: CGPoint(x: point.x * multiply, y: point.y * multiply))
      }
      shape.close()
      let shapeTrack = SKShapeNode(path: shape.cgPath, centered: true)
      shapeTrack.position = CGPoint(x: 0, y: 50)
      shapeTrack.strokeColor = UIColor.white
      shapeTrack.fillColor = UIColor.green
      self.addChild(shapeTrack)
      
      //      shapeLayer.path = shape.cgPath
      //      shapeLayer.fillColor = UIColor(red: 0.95, green: 0.7, blue: 0.5, alpha: 1).cgColor
      //      shapeLayer.strokeColor = UIColor.black.cgColor
      //      shapeLayer.lineWidth = 0.5
      //      view.layer.addSublayer(shapeLayer)
    }
    
    
  }
  
  
  
  
  
  
  var movableNode : SKNode?
  var lastLocationInRoom: CGPoint?
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
    
    if let touch = touches.first {
      let location = touch.location(in: self)
      let touchedNodes = self.nodes(at: location)
      
      for node in touchedNodes {
        if node is bulbSpriteNode {
          if dragDropEnabled {
            // move bulb
            movableNode = node
            movableNode!.position = location
          } else {
            if createGroup {
              // check if bulb has been selected
              if selectedBulbs[node.name!]! == false {
                
                // add blinking animation
                let expandAction = SKAction.scale(to: 2, duration: 0.33)
                let contractAction = SKAction.scale(to: 1.5, duration: 0.33)
                let pulsateAction = SKAction.repeatForever(SKAction.sequence([expandAction, contractAction]))
                node.run(pulsateAction)
                
                // add bulb to collection of selected bulbs
                selectedBulbs[node.name!]! = true
              } else {
                // remove blinking animation
                node.removeAllActions()
                let restoreScaleAcction = SKAction.scale(to: 1.5, duration: 0.1)
                node.run(restoreScaleAcction)
                
                // remove bulb from collection of selected bulbs
                bulbs.removeValue(forKey: node.name!)
                selectedBulbs[node.name!]! = false
              }
              
              // check if we have group (at least two selected)
              if checkIfGroup() {
                var groupBulbs = [Bulb]()
                for bulb in bulbCollection {
                  if selectedBulbs[bulb.name] == true {
                    groupBulbs.append(bulb)
                  }
                }
                
                roomSceneDelegate?.selectedBulbs(bulbs: groupBulbs)
                roomSceneDelegate?.groupSelected(groupSelected: true)
              } else {
                roomSceneDelegate?.groupSelected(groupSelected: false)
              }
            } else {
              let bulbNode = node as! bulbSpriteNode
              if bulbNode.type == "bulb" {
                print("een enkele lamp")
              } else {
                print("een groep")
              }
            }
          }
        }
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    d.c(m: "start", f: #file, fu: #function, l: #line)
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
    d.c(m: "start", f: #file, fu: #function, l: #line)
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
    d.c(m: "start", f: #file, fu: #function, l: #line)
    if touches.first != nil {
      movableNode = nil
    }
  }
  
  
  
  
  
  
  
  func checkIfGroup() -> Bool{
    d.c(m: "start", f: #file, fu: #function, l: #line)
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
    d.c(m: "start", f: #file, fu: #function, l: #line)
    
    let group = [Bulb]()
    
    self.groupCollection.append(group)
    
    createGroup = true
    
  }
  
}
