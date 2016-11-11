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
    
    
    
    
    let dataSource = DataSource.sharedInstance
    
    var bulbCollection = [Bulb]()
    
    
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
                    movableNode = node
                    movableNode!.position = location
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
            
            print("gevonden nodes: \(testForGroup(location: location).count)")
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    func testForGroup(location: CGPoint) -> [SKSpriteNode]  {
        let touchedNodes = self.nodes(at: location)
        
        var foundBulbs = [SKSpriteNode]()
        for node in touchedNodes {
            if node is SKSpriteNode {
                foundBulbs.append(node as! SKSpriteNode)
            }
        }
        return foundBulbs
    }
    
    func createGroup(node: [SKSpriteNode]) {
        
    }
    
}
