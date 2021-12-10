import UIKit

class AddPropertyAmenitiesViewController: UIViewController {

    @IBOutlet weak var txtOtherFeatures: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UIBUTTON ACTIONS
extension AddPropertyAmenitiesViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func previousClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        Helper.showLoader(onVC: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            Helper.hideLoader(onVC: self)
            
            for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) {
                if controller.isKind(of: AgentDashboardViewController.self) {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        })
    }
    
    @IBAction func equpiedKitchenClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func gymClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func laundryClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func mediaRoomClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func backyardClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func basketballCourtClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func frontyardClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func garageAttachedClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func hotBathClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func poolClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func centralAirClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func electricityClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func heatingClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func naturalGasClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func ventilationClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func waterClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func chairAccessibleClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func elevatorClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func fireplaceClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func smokeDetectorsClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func washerAndDryerClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func wifiClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

// MARK: - UITEXTVIEW DELEGATE
extension AddPropertyAmenitiesViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Other features (separate with ',')"
            textView.textColor = MubooniColors.placeholderColor
        }
    }
}

// MARK: - API CALL
extension AddPropertyAmenitiesViewController {
    func addProperty() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_ESTATE_TYPE_ID: AddProperty.estateId as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_ESTATE_NAME: AddProperty.estateName as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_USER_ID: AddProperty.userId as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_ADDRESS: AddProperty.address as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_GEO_LOCATION: AddProperty.geoLocation as AnyObject]
    }
}
