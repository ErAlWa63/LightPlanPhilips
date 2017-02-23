import UIKit

class RoomType {
  var name      : String
  var pictogram : UIImage
  var description: String
  
  init(name: String, file: String) {
    self.name      = name
    self.pictogram = UIImage(named: file)!
    self.description = ""
  }
  init(name: String, file: String, description: String) {
    self.name      = name
    self.pictogram = UIImage(named: file)!
    self.description = description
  }
}
