import UIKit

class FindServiceProviderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UIBUTTON ACTIONS
extension FindServiceProviderViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notificationClicked(_ sender: UIButton) {
        
    }
}
