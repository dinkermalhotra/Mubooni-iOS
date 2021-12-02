import UIKit

class ServiceProviderDetailViewController: UIViewController {

    var userProfile: UserProfile?
    var serviceProvider: ServiceProviders?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UIBUTTON ACTIONS
extension ServiceProviderDetailViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
