//
//  MyRoomTableViewCell.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 30/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// http://shrikar.com/uitableview-and-uitableviewcell-customization-in-swift/
//

import UIKit

class MyRoomTableViewCell: UITableViewCell {
  
  @IBOutlet weak var pictogramCell: UIImageView!
  @IBOutlet weak var nameCell: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
