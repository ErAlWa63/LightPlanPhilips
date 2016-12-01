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
    var id: String
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: NodeType, id: String) {
      self.type = type
      self.id = id
      super.init(texture: texture, color: color, size: size)
    }
    
    
    convenience init(type: NodeType, id: String) {
      //self.type = type
      switch type {
      case .bulb:
        let image = SKTexture(imageNamed: "Bulb")
        self.init(texture: image, color: UIColor.black, size: CGSize(width:40.0, height:40.0), type: type, id: id)
      case .group:
        let image = SKTexture(imageNamed: "Bulb group")
        self.init(texture: image, color: UIColor.black, size: CGSize(width:40.0, height:40.0), type: type, id: id)
      }
    }
    
    convenience init(lightTypeIcon: UIImage, type: NodeType, id: String){
      let image = lightTypeIcon
      let texture = SKTexture(image: image)
      self.init(texture: texture, color: UIColor.black, size: CGSize(width:40.0, height:40.0), type: type, id: id)
    }
    
    
    override convenience init(texture: SKTexture?, color: UIColor, size: CGSize) {
      self.init(texture: texture, color: color, size: size, type: NodeType.bulb, id: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
