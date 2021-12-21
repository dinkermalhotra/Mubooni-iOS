import UIKit

class InquirySubmissionViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtVisitDate: UITextField!
    @IBOutlet weak var txtVisitTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtVisitDate.datePicker(self, #selector(doneVisitDateAction), #selector(cancelVisitDateAction))
        txtVisitTime.datePicker(self, #selector(doneVisitTimeAction), #selector(cancelVisitTimeAction), .time)
    }

    @objc func cancelVisitDateAction() {
        txtVisitDate.resignFirstResponder()
    }
    
    @objc func cancelVisitTimeAction() {
        txtVisitTime.resignFirstResponder()
    }

    @objc func doneVisitDateAction() {
        if let datePickerView = txtVisitDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: datePickerView.date)
            txtVisitDate.text = dateString
            txtVisitDate.resignFirstResponder()
        }
    }
    
    @objc func doneVisitTimeAction() {
        if let datePickerView = txtVisitTime.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let dateString = dateFormatter.string(from: datePickerView.date)
            txtVisitTime.text = dateString
            txtVisitTime.resignFirstResponder()
        }
    }
}

// MARK: - UIBUTTON ACTIONS
extension InquirySubmissionViewController {
    @IBAction func crossClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if txtName.text?.isEmpty ?? true || txtEmail.text?.isEmpty ?? true || txtPhone.text?.isEmpty ?? true || txtVisitDate.text?.isEmpty ?? true || txtVisitTime.text?.isEmpty ?? true {
            Helper.showOKAlert(onVC: self, title: AlertMessages.ALL_FIELDS_ARE_MANDATORY, message: "")
        }
        else if (emailTest.evaluate(with: self.txtEmail.text?.lowercased()) == false) {
            Helper.showOKAlert(onVC: self, title: AlertMessages.ENTER_VALID_EMAIL, message: "")
        }
        else {
            Helper.showLoader(onVC: self)
            
            sendInquiry(Helper.convertDateAndTime("\(txtVisitDate.text ?? "") \(txtVisitTime.text ?? "")"))
        }
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

// MARK: - API CALL
extension InquirySubmissionViewController {
    func sendInquiry(_ date: String) {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_NAME: txtName.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_EMAIL: txtEmail.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_PHONE: txtPhone.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_SCHEDULE_INFO: date as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_USER_ID: "" as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_EST_ID: "2" as AnyObject]
        WSManager.wsCallSendInquiry(params) { isSuccess, message in
            Helper.hideLoader(onVC: self)
            
            if isSuccess {
                Helper.showOKAlertWithCompletion(onVC: self, title: message, message: "", btnOkTitle: Strings.OK, onOk: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
}
