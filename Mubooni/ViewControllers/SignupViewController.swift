import UIKit
import DropDown

class SignupViewController: UIViewController {

    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtSpecilization: UITextField!
    @IBOutlet weak var imgTenant: UIImageView!
    @IBOutlet weak var imgAgent: UIImageView!
    @IBOutlet weak var imgLandlord: UIImageView!
    @IBOutlet weak var imgServiceProvider: UIImageView!
    @IBOutlet weak var viewConfirmPassword: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewSpecilization: UIView!
    @IBOutlet weak var viewPasswordTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnRegisterTopConstraint: NSLayoutConstraint!
    
    var userRole = ""
    var showSpecilization = false
    var specilizationDropDown = DropDown()
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

        hideShowSpecilization()
        setData()
        setupSpecilizationDropDown()
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
    
    func setData() {
        if UserData.name != nil {
            txtName.text = UserData.name
            txtEmail.text = UserData.email
            
            viewConfirmPassword.isHidden = true
            viewPassword.isHidden = true
            btnRegisterTopConstraint.constant = 60
        }
        else {
            viewConfirmPassword.isHidden = false
            viewPassword.isHidden = false
            btnRegisterTopConstraint.constant = 192
        }
    }
    
    func setupSpecilizationDropDown() {
        var specilizations = [String]()
        for i in 0..<(Singleton.specilizations?.count ?? 0) {
            let dict = Singleton.specilizations?[i]
            
            specilizations.append(dict?.specification ?? "")
        }
        
        self.specilizationDropDown.anchorView = self.viewSpecilization
        self.specilizationDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        self.specilizationDropDown.dataSource = specilizations
        self.specilizationDropDown.backgroundColor = UIColor.white
        self.specilizationDropDown.textColor = UIColor.black
        self.specilizationDropDown.selectedTextColor = UIColor.black
        self.specilizationDropDown.separatorColor = UIColor.clear
        self.specilizationDropDown.textFont = MubooniFonts.FONT_ROBOTO_REGULAR_14 ?? UIFont.systemFont(ofSize: 14)
        self.specilizationDropDown.selectionAction = { [weak self] (index, item) in
            self?.txtSpecilization.text = item
        }
    }
}

// MARK: - UIBUTTON ACTIONS
extension SignupViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func showHideConfirmPasswordClicked(_ sender: UIButton) {
        if sender.isSelected {
            txtConfirmPassword.isSecureTextEntry = true
            sender.isSelected = false
        }
        else {
            txtConfirmPassword.isSecureTextEntry = false
            sender.isSelected = true
        }
    }
    
    @IBAction func tenantClicked(_ sender: UIButton) {
        imgTenant.isHidden = false
        imgAgent.isHidden = true
        imgLandlord.isHidden = true
        imgServiceProvider.isHidden = true
        userRole = Strings.ROLE_ID_TENANT
        
        showSpecilization = false
        hideShowSpecilization()
    }
    
    @IBAction func agentClicked(_ sender: UIButton) {
        imgTenant.isHidden = true
        imgAgent.isHidden = false
        imgLandlord.isHidden = true
        imgServiceProvider.isHidden = true
        userRole = Strings.ROLE_ID_AGENT
        
        showSpecilization = false
        hideShowSpecilization()
    }
    
    @IBAction func landlordClicked(_ sender: UIButton) {
        imgTenant.isHidden = true
        imgAgent.isHidden = true
        imgLandlord.isHidden = false
        imgServiceProvider.isHidden = true
        userRole = Strings.ROLE_ID_LANDLORD
        
        showSpecilization = false
        hideShowSpecilization()
    }
    
    @IBAction func serviceProviderClicked(_ sender: UIButton) {
        imgTenant.isHidden = true
        imgAgent.isHidden = true
        imgLandlord.isHidden = true
        imgServiceProvider.isHidden = false
        userRole = Strings.ROLE_ID_SERVICE_PROVIDER
        
        showSpecilization = true
        hideShowSpecilization()
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        Helper.showLoader(onVC: self)
        self.signupUser()
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSpecilization {
            specilizationDropDown.show()
            return false
        }
        else {
            return true
        }
    }
}

// MARK: - API CALL
extension SignupViewController {
    func signupUser() {
        var params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_NAME: txtName.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_EMAIL: txtEmail.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_PASSWORD: txtPassword.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_PHONE: txtPhone.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_USER_ROLE: userRole as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_COUNTRY_CODE: "+91" as AnyObject]
        if UserData.googleId != nil {
            params[WSRequestParams.WS_REQS_PARAM_GOOGLE_ID] = UserData.googleId as AnyObject
        }
        else if UserData.facebookId != nil {
            params[WSRequestParams.WS_REQS_PARAM_FACEBOOK_ID] = UserData.facebookId as AnyObject
        }
        
        WSManager.wsCallRegistration(params) { isSuccess, message, userProfile in
            Helper.hideLoader(onVC: self)
            if isSuccess {
                if UserData.googleId != nil || UserData.facebookId != nil {
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
                    Helper.showOKAlertWithCompletion(onVC: self, title: "", message: message, btnOkTitle: Strings.OK, onOk: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
}
