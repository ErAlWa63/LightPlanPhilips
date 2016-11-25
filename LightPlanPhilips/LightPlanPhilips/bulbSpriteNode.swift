//
//  bulbSpriteNode.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 21-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import SpriteKit

enum NodeType {
  case bulb
  case group
}


class BulbSpriteNode: SKSpriteNode {
  
  var type: NodeType
  
  
  init(texture: SKTexture?, color: UIColor, size: CGSize, type: NodeType) {
    self.type = type
    super.init(texture: texture, color: color, size: size)
  }


  convenience init(type: NodeType) {
    //self.type = type
    switch type {
    case .bulb:
      let image = SKTexture(imageNamed: "Bulb")
      self.init(texture: image, color: UIColor.black, size: CGSize(width:40.0, height:40.0), type: type)
    case .group:
      let image = SKTexture(imageNamed: "Bulb group")
      self.init(texture: image, color: UIColor.black, size: CGSize(width:40.0, height:40.0), type: type)
    }
  }
  
//  convenience init(imageName: String) {
//    let image = SKTexture(imageNamed: imageName)
//    self.init(texture: image, color: UIColor.black, size: CGSize(width:40.0, height:40.0))
//  }
//
//  
  
  
  override convenience init(texture: SKTexture?, color: UIColor, size: CGSize) {
    self.init(texture: texture, color: color, size: size, type: NodeType.bulb)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }



}
