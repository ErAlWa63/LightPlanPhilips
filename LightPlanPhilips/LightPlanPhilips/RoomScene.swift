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
  var delegateRoomSizeAdjust: Bool?
  
  var roomSceneDelegate: RoomSceneDelegate?
  
  var dragDropEnabled: Bool?
  var createGroup: Bool?
  
  let dataSource = DataSource.sharedInstance
  
  var bulbCollection = [Bulb]()
  var groups: [Group] = []
  var groupCollection = [[Bulb]]()
  var selectedBulbs = [String:Bool]()
  var bulbs = [String: Bulb ]()
  

//  let bulbSprite = bulbSpriteNode(imageNamed: "Bulb")
//  let groupSprite = bulbSpriteNode(imageNamed: "Bulb group")
  var selectedNode = BulbSpriteNode()


  
  
  override func didMove(to view: SKView) {
    // get bulbs
    // get groups
    
    if let roomSceneDelegate = roomSceneDelegate {
      d.c(m: "start", f: #file, fu: #function, l: #line)
      bulbCollection = roomSceneDelegate.getBulbs()
    }
    //    bulbCollection = (roomSceneDelegate?.getBulbs())!
    
        groups = (roomSceneDelegate?.getGroups())!
    
    //place bulbs
    for bulb in bulbCollection {
      // create sprite with type image and type
      let sprite = BulbSpriteNode(type:NodeType.bulb, id: bulb.id)
      sprite.position = CGPoint(x: CGFloat(bulb.positionX!), y: CGFloat(bulb.positionY!))
      sprite.setScale(1.5)
      sprite.name = bulb.name
      selectedBulbs[bulb.name] = false
      self.addChild(sprite)
    }
    
    // place groups
    for group in groups {
      let sprite = BulbSpriteNode(type: NodeType.group, id: group.id)
      sprite.position = CGPoint(x: CGFloat(group.positionX!), y: CGFloat(group.positionY!))
      sprite.setScale(1.5)
      sprite.name = group.name
      
      self.addChild(sprite)
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
        if node is BulbSpriteNode {
          if dragDropEnabled! {
            // move bulb
            movableNode = node
            movableNode!.position = location
          } else {
            if createGroup! {
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
              let bulbNode = node as! BulbSpriteNode
              if bulbNode.type == NodeType.bulb {
            
            
                roomSceneDelegate?.clickBulb(id: bulbNode.id, segue: "NameLight")


                
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
