//
//  RoomShapeViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 16/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class RoomShapeViewController: UIViewController {
  let d = D() // debugger functionality
  let shapeLayer = CAShapeLayer()
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cellButton(_ sender: Any) {
    let cellButton = sender as! UIButton
    DataLightPlan.sharedInstance.processCell( index: Int(cellButton.currentTitle!)!) ? cellButton.color(rgbValue: 0xE7BF7E) : cellButton.color(rgbValue: 0xD8D8D8)
    nextButton.isHidden = DataLightPlan.sharedInstance.countCell > 0 ? false : true
    
//    edge = DataLightPlan.sharedInstance.processNext()
//    if edge.count != 0 {
//      let shape = UIBezierPath()
//      let offX = 38
//      let offY = 167
//      let multiply = 35
//      shape.move(to: CGPoint(x: offX + edge[0].x * multiply, y: offY + edge[0].y * multiply))
//      for point in edge {
//        shape.addLine(to: CGPoint(x: offX + point.x * multiply, y: offY + point.y * multiply))
//      }
//      shape.close()
//      shapeLayer.path = shape.cgPath
//          shapeLayer.fillColor = UIColor(red: 0.95, green: 0.7, blue: 0.5, alpha: 1).cgColor
//      shapeLayer.strokeColor = UIColor.black.cgColor
//      shapeLayer.lineWidth = 0.5
//      view.layer.addSublayer(shapeLayer)
//    }
  }
  
  @IBAction func nextButton(_ sender: Any) {
    DataLightPlan.sharedInstance.edge = DataLightPlan.sharedInstance.processNext()
  }
  
  @IBOutlet weak var nextButton: UIButton!

//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    d.c(m: "start", f: #file, fu: #function, l: #line)
//    d.c(m: "segue.identifier = \(segue.identifier)", f: #file, fu: #function, l: #line)
//    if(segue.identifier == "SelectRoomTypeSegue") {
//      d.c(m: "SelectRoomTypeSegue", f: #file, fu: #function, l: #line)
//      if let SelectRoomTypeViewController = segue.destination as? SelectRoomTypeViewController {
//        d.c(m: "SelectRoomTypeViewController", f: #file, fu: #function, l: #line)
//        if let myHome = myHome {
//          d.c(m: "myHome", f: #file, fu: #function, l: #line)
//          SelectRoomTypeViewController.delegateRoom = myHome.room
//          SelectRoomTypeViewController.closureToPerform = { [weak self] (rooms: [Room]) in
//            if let strongSelf = self {
//              if var myHome = strongSelf.myHome {
//                myHome.room = rooms
//              }
//            }
//          }
//        }
//      }
//    }
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    d.c(m: "start", f: #file, fu: #function, l: #line)
    
    DataLightPlan.sharedInstance.toggle = DataLightPlan.sharedInstance.toggle.map{ _ in false}
    nextButton.isHidden = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    d.c(m: "start", f: #file, fu: #function, l: #line)
  }
}

