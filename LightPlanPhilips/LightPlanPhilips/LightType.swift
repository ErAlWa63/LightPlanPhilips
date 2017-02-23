import UIKit

class LightType: NSObject {
    var name      : String
    var pictogram : UIImage
    
    init(name: String, file: String) {
        self.name      = name
        self.pictogram = UIImage(named: file)!
    }
}
