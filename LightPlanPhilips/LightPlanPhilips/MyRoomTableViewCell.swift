import UIKit

class MyRoomTableViewCell: UITableViewCell {
  @IBOutlet weak var pictogramCell: UIImageView!
  @IBOutlet weak var nameCell: UILabel!
  @IBOutlet weak var descriptionCell: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
