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
  
  var roomSceneDelegate: RoomSceneDelegate?
  
  var dragDropEnabled: Bool = true
  var createGroup: Bool = false
  
  let dataSource = DataSource.sharedInstance
  
  var bulbCollection = [Bulb]()
  var groupCollection = [[Bulb]]()
  
  
  let bulbSprite = SKSpriteNode(imageNamed: "Bulb")
  let groupSprite = SKSpriteNode(imageNamed: "Bulb group")
  var selectedNode = SKSpriteNode()
  
  override func didMove(to view: SKView) {
    
    bulbCollection = dataSource.GetBulbs()
    
    for bulb in bulbCollection {
      let sprite = bulbSprite.copy() as! SKSpriteNode
      sprite.position = CGPoint(x: bulb.positionX!, y: bulb.positionY!)
      sprite.setScale(1.5)
      sprite.name = bulb.name
      sprite.isSelected = false
      self.addChild(sprite)
    }
  }
  
  
  
  
  
  
  var movableNode : SKNode?
  var lastLocationInRoom: CGPoint?
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    if let touch = touches.first {
      let location = touch.location(in: self)
      let touchedNodes = self.nodes(at: location)
      for node in touchedNodes {
        if node is SKSpriteNode {
          if dragDropEnabled {
            movableNode = node
            movableNode!.position = location
          } else {
            
            
            if node.isSelected == false {
              
              let expandAction = SKAction.scale(to: 2, duration: 0.33)
              let contractAction = SKAction.scale(to: 1.5, duration: 0.33)
              let pulsateAction = SKAction.repeatForever(SKAction.sequence([expandAction, contractAction]))
              
              node.run(pulsateAction)
              
              node.isSelected = true
            } else {
              
              
              node.removeAllActions()
              let restoreScaleAcction = SKAction.scale(to: 1.5, duration: 0.1)
              node.run(restoreScaleAcction)
              
              node.isSelected = false
            }
          }
        }
      }
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    if touches.first != nil {
      movableNode = nil
    }
  }
  
  //  func testForGroup(location: CGPoint) -> [SKSpriteNode]  {
  //    let touchedNodes = self.nodes(at: location)
  //
  //    var foundBulbs = [SKSpriteNode]()
  //    for node in touchedNodes {
  //      if node is SKSpriteNode {
  //        foundBulbs.append(node as! SKSpriteNode)
  //      }
  //    }
  //    return foundBulbs
  //  }
  
  func createNewGroup() {
    
    var group = [Bulb]()
    
    self.groupCollection.append(group)
    
    createGroup = true
    
  }
  
}
