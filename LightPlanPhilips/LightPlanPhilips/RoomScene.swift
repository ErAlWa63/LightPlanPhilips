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
    var selectedNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        bulbCollection = dataSource.GetBulbs()
        
        for bulb in bulbCollection {
            let sprite = bulbSprite.copy() as! SKSpriteNode
            sprite.position = CGPoint(x: bulb.positionX!, y: bulb.positionY!)
            sprite.name = bulb.name
            
            self.addChild(sprite)
        }
    }
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let positionInScene = touch.location(in: self)
            
            selectNodeForTouch(touchLocation: positionInScene)
        }
        
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let positionInScene = touch.location(in: self)
            let previousPosition = touch.previousLocation(in: self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
            panForTranslation(translation: translation)
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       //selectedNode = nil
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        
        let touchedNodes = self.nodes(at: touchLocation)
        
        for node in touchedNodes {
            if node is SKSpriteNode {
                if !selectedNode.isEqual(node) {
                    selectedNode = node as! SKSpriteNode
                }
            }
        }
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode.position
        
        
        selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        
    }
    
}
