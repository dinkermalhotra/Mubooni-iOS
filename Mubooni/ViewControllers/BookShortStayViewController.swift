import UIKit

class BookShortStayViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtCheckIn: UITextField!
    @IBOutlet weak var txtCheckOut: UITextField!
    @IBOutlet weak var lblTotalDaysCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    var property: Properties?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCheckIn.datePicker(self, #selector(doneCheckInAction), #selector(cancelCheckInAction))
        txtCheckOut.datePicker(self, #selector(doneCheckOutAction), #selector(cancelCheckOutAction))
    }

    @objc func cancelCheckInAction() {
        txtCheckIn.resignFirstResponder()
    }
    
    @objc func cancelCheckOutAction() {
        txtCheckOut.resignFirstResponder()
    }

    @objc func doneCheckInAction() {
        if let datePickerView = txtCheckIn.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: datePickerView.date)
            txtCheckIn.text = dateString
            txtCheckIn.resignFirstResponder()
        }
    }
    
    @objc func doneCheckOutAction() {
        if let datePickerView = txtCheckOut.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: datePickerView.date)
            txtCheckOut.text = dateString
            lblTotalDaysCount.text = "2"
            lblTotalPrice.text = "2800"
            txtCheckOut.resignFirstResponder()
        }
    }
}

// MARK: - UIBUTTON ACTION
extension BookShortStayViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension BookShortStayViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName {
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail {
            txtPhone.becomeFirstResponder()
        }
        else if textField == txtPhone {
            txtId.becomeFirstResponder()
        }
        else if textField == txtId {
            txtCheckIn.becomeFirstResponder()
        }
        else if textField == txtCheckIn {
            txtCheckOut.becomeFirstResponder()
        }
        else {
            txtCheckOut.resignFirstResponder()
        }
        
        return true
    }
}
