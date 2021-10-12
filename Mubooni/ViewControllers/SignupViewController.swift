import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

// MARK: - UIBUTTON ACTIONS
extension SignupViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tenantClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func agentClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func landlordClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func serviceProviderClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        
    }
}
