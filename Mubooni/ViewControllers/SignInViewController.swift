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
        if txtEmail.text?.isEmpty ?? true || txtPassword.text?.isEmpty ?? true {
            Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: AlertMessages.WRONG_EMAIL_PASSWORD)
        }
        else {
            Helper.showLoader(onVC: self)
            self.loginUser()
        }
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

// MARK: - API CALL
extension SignInViewController {
    func loginUser() {
        var params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_EMAIL: txtEmail.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_PASSWORD: txtPassword.text as AnyObject]
        WSManager.wsCallLogin(params) { isSuccess, message, userProfile in
            Helper.hideLoader(onVC: self)
            if isSuccess {
                if let vc = ViewControllerHelper.getViewController(ofType: .AgentDashboardViewController) as? AgentDashboardViewController {
                    vc.userProfile = userProfile
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
}
