//
//  RoomShapeViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 16/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class RoomShapeViewController: UIViewController {
  let addFrame4    = [ true,  true, false,  true,  true, false,  true,  true]
  let removeFrame4 = [ true,  true,  true,  true,  true, false,  true,  true]
  let addFrame6    = [ true,  true, false,  true,  true, false,  true,  true,
                       false, false, false, false,  true, false,  true,  true,
                       true, false, false, false, false, false, false, false,
                       true, false, false, false,  true, false,  true,  true]
  let removeFrame6 = [ true]
  let addFrame9    = [ true]
  let removeFrame9 = [ true]
  
  var cellN = false
  var cellNE = false
  var cellE = false
  var cellSE = false
  var cellS = false
  var cellSW = false
  var cellW = false
  var cellNW = false
  
  struct Point {
    var x: Int
    var y: Int
    init () {
      x = 0
      y = 0
    }
  }
//  let index2Point = [ Point(0,0), Point(1,0)]

  struct Cell {
    var Point = (0, 0)
    var state = false
    
  }
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
