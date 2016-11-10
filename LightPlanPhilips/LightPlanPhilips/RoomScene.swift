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
    
    
    var bulbSprite = SKSpriteNode(imageNamed: "Bulb")
    
    override func didMove(to view: SKView) {
    
        bulbCollection = dataSource.GetBulbs()
        
        
        
        for bulb in bulbCollection {
            bulbSprite.position = CGPoint(x: bulb.positionX!, y: bulb.positionY!)
            bulbSprite.name = bulb.name
            
            self.addChild(bulbSprite)
            print("created")
        }
        

        //bulbSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
//        bulbSprite1.position = CGPoint(x: 100, y:100)
//        bulbSprite1.name = "lamp 1"
//        bulbSprite2.position = CGPoint(x: 0, y:0)
//        bulbSprite2.name = "lamp 2"
//        bulbSprite3.position = CGPoint(x: 0, y:100)
//        bulbSprite3.name = "lamp 3"

        


        

        
    }
    

    
    
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let positionInScene = touch.location(in: self)
            
            selectNodeForTouch(touchLocation: positionInScene)
        }
        
      
    }
    
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * M_PI)
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        // 1

        
        let touchedNodes = self.nodes(at: touchLocation)
        

        for node in touchedNodes {
            if node is SKSpriteNode {
                print("hoera  \(node)")
            }
        }
        
                   //            // 2
//            if !selectedNode.isEqual(touchedNode) {
//                selectedNode.removeAllActions()
//                selectedNode.runAction(SKAction.rotateToAngle(0.0, duration: 0.1))
//                
//                selectedNode = touchedNode as! SKSpriteNode
//                
//                // 3
//                if touchedNode.name! == kAnimalNodeName {
//
//                }
//            }
       //}
    }
    
}
