//
//  SKSpriteNodeExtension.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 15-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import SpriteKit


extension SKSpriteNode {
  
  func addGlow(radius: Float = 30) {
    let effectNode = SKEffectNode()
    effectNode.shouldRasterize = true
    addChild(effectNode)
    effectNode.addChild(SKSpriteNode(texture: texture))
    effectNode.filter = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius":radius])
  }
}
