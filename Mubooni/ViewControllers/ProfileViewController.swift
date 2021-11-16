import UIKit

class ProfileViewController: UIViewController {

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
