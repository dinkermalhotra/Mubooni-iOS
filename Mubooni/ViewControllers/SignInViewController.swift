import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var _settings: SettingsManager?
    
    var settings: SettingsManagerProtocol?
    {
        if let _ = WSManager._settings {
        }
        else {
            WSManager._settings = SettingsManager()
        }

        return WSManager._settings
    }
    
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
    
    @IBAction func showHidePasswordClicked(_ sender: UIButton) {
        if sender.isSelected {
            txtPassword.isSecureTextEntry = true
            sender.isSelected = false
        }
        else {
            txtPassword.isSecureTextEntry = false
            sender.isSelected = true
        }
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
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_EMAIL: txtEmail.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_PASSWORD: txtPassword.text as AnyObject]
        WSManager.wsCallLogin(params) { isSuccess, message, userProfile in
            Helper.hideLoader(onVC: self)
            if isSuccess {
                self.settings?.userProfile = userProfile
                
                if userProfile?.roleId == Strings.ROLE_ID_SERVICE_PROVIDER {
                    if let vc = ViewControllerHelper.getViewController(ofType: .ServiceProviderDashboardViewController) as? ServiceProviderDashboardViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else if userProfile?.roleId == Strings.ROLE_ID_TENANT {
                    if let vc = ViewControllerHelper.getViewController(ofType: .TenantDashboardViewController) as? TenantDashboardViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else {
                    if let vc = ViewControllerHelper.getViewController(ofType: .AgentDashboardViewController) as? AgentDashboardViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
}
