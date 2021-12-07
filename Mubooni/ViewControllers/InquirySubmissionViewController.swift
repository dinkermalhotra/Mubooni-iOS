import UIKit

class InquirySubmissionViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtVisitDate: UITextField!
    @IBOutlet weak var txtVisitTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UIBUTTON ACTIONS
extension InquirySubmissionViewController {
    @IBAction func crossClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension InquirySubmissionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName {
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail {
            txtPhone.becomeFirstResponder()
        }
        else if textField == txtPhone {
            txtVisitDate.becomeFirstResponder()
        }
        else if textField == txtVisitDate {
            txtVisitTime.becomeFirstResponder()
        }
        else {
            txtVisitTime.resignFirstResponder()
        }
        
        return true
    }
}
