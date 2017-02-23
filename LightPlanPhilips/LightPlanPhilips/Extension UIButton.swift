import UIKit

extension UIButton {
  func color( rgbValue: UInt) {
    backgroundColor = UIColorFromRGB(rgbValue: rgbValue)
    setTitleColor(UIColorFromRGB(rgbValue: rgbValue), for: .normal)
  }
  
  private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor( red: CGFloat((rgbValue >> 16) & 0xFF) / 255.0, green: CGFloat((rgbValue >> 8) & 0xFF) / 255.0, blue: CGFloat(rgbValue & 0xFF) / 255.0, alpha: CGFloat(1.0))
  }
  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let relativeFrame = self.bounds
    let hitTestEdgeInsets = UIEdgeInsetsMake(-8, -8, -8, -8)
    let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
    return hitFrame.contains(point)
  }
}
