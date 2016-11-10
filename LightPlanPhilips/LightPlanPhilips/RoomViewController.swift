//
//  RoomViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 09-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//



import UIKit
import SpriteKit
//import GameplayKit

class RoomViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'RoomScene.sks'
            if let scene = SKScene(fileNamed: "RoomScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

    
}
