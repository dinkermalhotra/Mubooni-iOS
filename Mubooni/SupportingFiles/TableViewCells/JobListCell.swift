import UIKit

class JobListCell: UITableViewCell {
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var propertylbl: UILabel!
    @IBOutlet weak var issueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
