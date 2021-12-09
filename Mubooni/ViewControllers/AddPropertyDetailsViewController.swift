import UIKit

class AddPropertyDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtOwnerName: UITextField!
    @IBOutlet weak var txtOwnerNotes: UITextView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var numberOfRows = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.addObserver(self, forKeyPath: Strings.CONTENT_SIZE, options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tableView.removeObserver(self, forKeyPath: Strings.CONTENT_SIZE)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Strings.CONTENT_SIZE {
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                tableViewHeightConstraint.constant = newsize.height
            }
        }
    }
}

// MARK: - UIBUTTON ACTIONS
extension AddPropertyDetailsViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addMoreUnitClicked(_ sender: UIButton) {
        numberOfRows = numberOfRows + 1
        tableView.reloadData()
    }
    
    @IBAction func internetClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func electricityClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func garbageClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func waterClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func serviceChargeClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func previousClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyAmenitiesViewController) as? AddPropertyAmenitiesViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension AddPropertyDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtOwnerNotes.becomeFirstResponder()
        
        return true
    }
}

// MARK: - UITEXTVIEW DELEGATE
extension AddPropertyDetailsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Owner/Agent Notes"
            textView.textColor = MubooniColors.placeholderColor
        }
    }
}

// MARK: - UITABLEVIEW METHODS
extension AddPropertyDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.AddPropertyUnitCell, for: indexPath) as! AddPropertyUnitCell
        
        return cell
    }
}
