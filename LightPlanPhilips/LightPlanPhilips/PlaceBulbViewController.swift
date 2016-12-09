//
//  PlaceBulbViewController.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 05-12-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit
import SpriteKit


class PlaceBulbViewController: SceneViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  var myHome : Home?
  var closureToPerform: ((Home) -> Void)?
  

  @IBAction func backButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelButton(_ sender: Any) {
    self.presentingViewController!.presentingViewController!.presentingViewController!.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
  }
  
  var scene: RoomScene!
  var bulbCollection: [Bulb] = []
  var groupCollection: [Group] = []
  
  let selectedRoom: Int = DataSource.sharedInstance.myHome.selectedRoom
  
  var roomId: String = ""
  
  var room: Room?
  var bulbId: String = ""
  
  let reuseIdentifier = "cell"
  var bulbsInHome = DataSource.sharedInstance.getBulbsInHome()
  
  let debug = Debug() // debugger functionality
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    roomId = DataSource.sharedInstance.myHome.rooms[selectedRoom].id
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.bulbsInHome.count
  }
  
  // make a cell for each cell index path
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // get a reference to our storyboard cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! addBulbCell
    
    cell.bulbName.text = self.bulbsInHome[indexPath.item].lightTypeName
    cell.bulbIcon.image = self.bulbsInHome[indexPath.item].lightTypeIcon
    
    return cell
  }
  

  
  // select bulb and place in room
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
    
    
    let bulb = self.bulbsInHome[indexPath.item]
    // check if the defaul placement position in room exists
    if self.room?.gridCellOptimized[24] == false {
      bulb.positionX = Float((scene.backupPosition?.x)!)
      bulb.positionY = Float((scene.backupPosition?.y)!)
    }
    
    print("h: \(self.view.frame.height)")
    print("w: \(self.view.frame.width)")
    
    
    
    
    print("x: \(self.scene.anchorPoint.x)")
    print("y: \(self.scene.anchorPoint.y)")
    print("h: \(self.scene.frame.height)")
    print("w: \(self.scene.frame.width)")
    
  
    bulb.positionX = Float(collectionView.frame.origin.x + (collectionView.cellForItem(at: indexPath)?.frame.origin.x)!)
    bulb.positionY = Float(collectionView.frame.origin.y + (collectionView.cellForItem(at: indexPath)?.frame.origin.y)!)
    
    
    scene.placeBulb(bulb: bulb)

    DataSource.sharedInstance.moveBulbFromHomeToRoom(bulbId: bulb.id, roomId: roomId)
    self.bulbsInHome = DataSource.sharedInstance.getBulbsInHome()
    self.bulbCollection = DataSource.sharedInstance.getBulbsInRoom(roomId: roomId)

    collectionView.deleteItems(at: [indexPath])
    
  }

  override func viewWillAppear(_ animated: Bool) {
    bulbCollection = DataSource.sharedInstance.getBulbsInRoom(roomId: roomId)
    groupCollection = DataSource.sharedInstance.getGroupsInRoom(roomId: roomId)
    room = DataSource.sharedInstance.getRoom(roomId: roomId)!
    
    
    
    if let view = self.view as! SKView? {
      // Create spritekit Roomscene
      scene = SKScene(fileNamed: "RoomScene") as! RoomScene
      scene.myHome = myHome
      scene.scaleMode = .aspectFill
      
      scene.roomSceneDelegate = self
      view.presentScene(scene)
      
      scene.dragDropEnabled = true
      scene.createGroup = false
      
      view.ignoresSiblingOrder = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  
  
  
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowBulbs" {
      let viewController = (segue.destination) as! RoomViewController
      viewController.room = self.room
      saveBulbs()
    }
  }
  
  
  
  
  func saveBulbs(){
    scene.enumerateChildNodes(withName: "//*", using:
      { (node, stop) -> Void in
        if node is BulbSpriteNode {
          for bulb in self.bulbCollection {
            let spriteNode = node as! BulbSpriteNode
            if bulb.id == spriteNode.id {
              bulb.positionX = Float(node.position.x)
              bulb.positionY = Float(node.position.y)
              break
            }
          }
          for group in self.groupCollection {
            let spriteNode = node as! BulbSpriteNode
            if group.id == spriteNode.id {
              group.positionX = Float(node.position.x)
              group.positionY = Float(node.position.y)
              break
            }
            
          }
          
          
        }
    })
  }
  
  
  
  
  // delegate functions
  override   func clickBulb(id: String, segue: String){
    self.bulbId = id
    performSegue(withIdentifier: segue, sender: nil)
  }
  
  override func getBulbs() -> [Bulb]{
    return self.bulbCollection
  }
  
  override func getGroups() -> [Group]{
    return self.groupCollection
  }
  
  
  override func getRoom() -> Room? {
    return self.room
  }
  
}
