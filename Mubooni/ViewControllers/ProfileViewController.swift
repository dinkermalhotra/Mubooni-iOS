import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileTag: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
}

// MARK: - UIBUTTON ACTIONS
extension ProfileViewController {
    @IBAction func profileClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
