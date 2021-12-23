import UIKit

protocol AddPropertyDetailsViewControllerDelegate {
    func refreshTableView()
}

var addPropertyDetailsViewControllerDelegate: AddPropertyDetailsViewControllerDelegate?

class AddPropertyDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtOwnerName: UITextField!
    @IBOutlet weak var txtOwnerNotes: UITextView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var numberOfRows = 1
    var params: [String: AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addPropertyDetailsViewControllerDelegate = self
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
    
    @IBAction func checkShortStay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? AddPropertyUnitCell {
            
            if cell.btnShortStay.isSelected {
                cell.viewShortStays.isHidden = false
                cell.shortStaysViewHeightConstraint.constant = 116
            }
            else {
                cell.viewShortStays.isHidden = true
                cell.shortStaysViewHeightConstraint.constant = 0
            }
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func addMoreUnitClicked(_ sender: UIButton) {
        numberOfRows = numberOfRows + 1
        tableView.reloadData()
    }
    
    @IBAction func internetClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        params[WSRequestParams.WS_REQS_PARAM_UTILITY_CHARGES_ARRAY] = sender.isSelected ? Strings.INTERNET as AnyObject : "" as AnyObject
    }
    
    @IBAction func electricityClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        params[WSRequestParams.WS_REQS_PARAM_UTILITY_CHARGES_ARRAY] = sender.isSelected ? Strings.ELECTRICITY as AnyObject : "" as AnyObject
    }
    
    @IBAction func garbageClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        params[WSRequestParams.WS_REQS_PARAM_UTILITY_CHARGES_ARRAY] = sender.isSelected ? Strings.GARBAGE as AnyObject : "" as AnyObject
    }
    
    @IBAction func waterClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        params[WSRequestParams.WS_REQS_PARAM_UTILITY_CHARGES_ARRAY] = sender.isSelected ? Strings.WATER as AnyObject : "" as AnyObject
    }
    
    @IBAction func serviceChargeClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        params[WSRequestParams.WS_REQS_PARAM_UTILITY_CHARGES_ARRAY] = sender.isSelected ? Strings.SERVICE_CHARGE as AnyObject : "" as AnyObject
    }
    
    @IBAction func previousClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        let ownerNotes = txtOwnerNotes.text != Strings.OWNER_NOTES ? txtOwnerNotes.text : ""
        params[WSRequestParams.WS_REQS_PARAM_ESTATE_TYPE_ID] = AddProperty.estateId as AnyObject
        params[WSRequestParams.WS_REQS_PARAM_ESTATE_NAME] = AddProperty.estateName as AnyObject
        params[WSRequestParams.WS_REQS_PARAM_USER_ID] = AddProperty.userId as AnyObject
        params[WSRequestParams.WS_REQS_PARAM_ADDRESS] = AddProperty.address as AnyObject
        params[WSRequestParams.WS_REQS_PARAM_GEO_LOCATION] = AddProperty.geoLocation as AnyObject
        params[WSRequestParams.WS_REQS_PARAM_OWNER_NAME] = txtOwnerName.text as AnyObject
        params[WSRequestParams.WS_REQS_PARAM_OWNER_NOTES] = ownerNotes as AnyObject
        
        for i in 0..<numberOfRows {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AddPropertyUnitCell {
                params[WSRequestParams.WS_REQS_PARAM_UNIT_STATUS_ARRAY] = cell.txtPropertyFor.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_UNIT_NO_ARRAY] = cell.txtUnitNumber.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_UNIT_TYPE_ARRAY] = cell.txtPropertyType.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_AREA_ARRAY] = cell.txtArea.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_AREA_TYPE_ARRAY] = cell.txtLength.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_MONTHLY_RENT_ARRAY] = cell.txtPrice.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_STAY_DAYS_ARRAY] = cell.txtNumberOfDays.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_PER_DAY_ARRAY] = cell.txtPerDayRent.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_TOTAL_PLOTS_ARRAY] = cell.txtNumberOfPlots.text as AnyObject
                params[WSRequestParams.WS_REQS_PARAM_CHECK_SHORT_STAY_ARRAY] = "\(cell.btnShortStay.isSelected)" as AnyObject
            }
        }
        
        if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyAmenitiesViewController) as? AddPropertyAmenitiesViewController {
            vc.finalParam = params
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - CUSTOM DELEGATE
extension AddPropertyDetailsViewController: AddPropertyDetailsViewControllerDelegate {
    func refreshTableView() {
        self.tableView.reloadData()
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
        if textView.text == Strings.OWNER_NOTES {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = Strings.OWNER_NOTES
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
        
        cell.btnShortStay.tag = indexPath.row
        cell.btnShortStay.addTarget(self, action: #selector(checkShortStay(_:)), for: .touchUpInside)
        
        return cell
    }
}
