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
  var selectedBulbs = [String:Bool]()
  
  let bulbSprite = SKSpriteNode(imageNamed: "Bulb")
  let groupSprite = SKSpriteNode(imageNamed: "Bulb group")
  var selectedNode = SKSpriteNode()
  
  override func didMove(to view: SKView) {
    
    
    self.roomSceneDelegate?.test()
    
    bulbCollection = (roomSceneDelegate?.getBulbs())!
    
    
    for bulb in bulbCollection {
      let sprite = bulbSprite.copy() as! SKSpriteNode
      sprite.position = CGPoint(x: CGFloat(bulb.positionX!), y: CGFloat(bulb.positionY!))
      sprite.setScale(1.5)
      sprite.name = bulb.name
      selectedBulbs[bulb.name] = false
      
      
      self.addChild(sprite)
    }
  }
  
  
  
  
  
  
  var movableNode : SKNode?
  var lastLocationInRoom: CGPoint?
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    if let touch = touches.first {
      let location = touch.location(in: self)
      let touchedNodes = self.nodes(at: location)
      
      print(selectedBulbs)
      
      
      for node in touchedNodes {
  
        if node is SKSpriteNode {
          if dragDropEnabled {
            movableNode = node
            movableNode!.position = location
          } else {
            
            
            
            
            if selectedBulbs[node.name!]! == false {
              
              let expandAction = SKAction.scale(to: 2, duration: 0.33)
              let contractAction = SKAction.scale(to: 1.5, duration: 0.33)
              let pulsateAction = SKAction.repeatForever(SKAction.sequence([expandAction, contractAction]))
              
              node.run(pulsateAction)
              
              
              selectedBulbs[node.name!]! = true
              
              
            } else {
              
              node.removeAllActions()
              let restoreScaleAcction = SKAction.scale(to: 1.5, duration: 0.1)
              node.run(restoreScaleAcction)
              
              
               selectedBulbs[node.name!]! = false
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
  

  
  func checkIfGroup() {
    
    var counter: Int = 0
    for bulb in selectedBulbs {
      if bulb.value == true {
        counter += 1
      }
      if counter >= 2 {
        
        //roomSceneDelegate?.enableButton(button: createGroup)
      } else {

      }
    }
 
  }
  
  func createNewGroup() {
    
    let group = [Bulb]()
    
    self.groupCollection.append(group)
    
    createGroup = true
    
  }
  
}
