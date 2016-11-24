  //
//  bulbSpriteNode.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 21-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import SpriteKit





class bulbSpriteNode: SKSpriteNode {
  
  var type: String
  
  
  init(texture: SKTexture?, color: UIColor, size: CGSize, type: String) {
    self.type = ""
    super.init(texture: texture, color: color, size: size)
  }



  
  convenience init(imageName: String) {
    let image = SKTexture(imageNamed: imageName)
    self.init(texture: image, color: UIColor.black, size: CGSize(width:40.0, height:40.0))
  }

  
  
  
  override convenience init(texture: SKTexture?, color: UIColor, size: CGSize) {
    self.init(texture: texture, color: color, size: size, type: "")
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }



}
