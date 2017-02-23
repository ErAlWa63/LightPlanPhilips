import UIKit

class NameLight: NSObject {
    var name           : String
    var lightTypeIndex : Int
    
    init(name: String, lightTypeIndex: Int) {
        self.name           = name
        self.lightTypeIndex = lightTypeIndex
    }
}
