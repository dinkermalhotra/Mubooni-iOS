import UIKit

class JobListCell: UITableViewCell {
    
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblPropertyAddress: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var btnAssignJob: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
