import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UIBUTTON ACTIONS
extension SignInViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotPasswordClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func LoginClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func registerNowClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .SignupViewController) as? SignupViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITEXTFIEL DELEGATE
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        else {
            txtPassword.resignFirstResponder()
        }
        
        return true
    }
}
