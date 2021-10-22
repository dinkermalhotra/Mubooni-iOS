import UIKit
import DropDown

class SignupViewController: UIViewController {

    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtSpecilization: UITextField!
    @IBOutlet weak var viewConfirmPassword: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewSpecilization: UIView!
    @IBOutlet weak var viewPasswordTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnRegisterTopConstraint: NSLayoutConstraint!
    
    var showSpecilization = false
    var specilizationDropDown = DropDown()
    
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
