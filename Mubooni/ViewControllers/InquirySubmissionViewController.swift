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
