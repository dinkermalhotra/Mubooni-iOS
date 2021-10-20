import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtSpecilization: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var viewSpecilization: UIView!
    @IBOutlet weak var viewPasswordTopConstraint: NSLayoutConstraint!
    
    var showSpecilization = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideShowSpecilization()
    }
    
    func hideShowSpecilization() {
        UIView.animate(withDuration: 0.1, animations: {
            if self.showSpecilization {
                self.viewSpecilization.isHidden = false
                self.viewPasswordTopConstraint.constant = 82
            }
            else {
                self.viewSpecilization.isHidden = true
                self.viewPasswordTopConstraint.constant = 18
            }
        }, completion: nil)
    }
    
}

// MARK: - UIBUTTON ACTIONS
extension SignupViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tenantClicked(_ sender: UIButton) {
        showSpecilization = false
        hideShowSpecilization()
    }
    
    @IBAction func agentClicked(_ sender: UIButton) {
        showSpecilization = false
        hideShowSpecilization()
    }
    
    @IBAction func landlordClicked(_ sender: UIButton) {
        showSpecilization = false
        hideShowSpecilization()
    }
    
    @IBAction func serviceProviderClicked(_ sender: UIButton) {
        showSpecilization = true
        hideShowSpecilization()
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        
    }
}
