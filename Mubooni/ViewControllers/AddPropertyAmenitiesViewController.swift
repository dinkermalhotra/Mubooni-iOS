import UIKit

class AddPropertyAmenitiesViewController: UIViewController {

    @IBOutlet weak var txtOtherFeatures: UITextView!
    
    var finalParam = [String: AnyObject]()
    
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
        finalParam[WSRequestParams.WS_REQS_PARAM_EXTRA_FEATURES] = txtOtherFeatures.text as AnyObject
        AddProperty.unitParams = finalParam
        
        Helper.showLoader(onVC: self)
        addProperty()
    }
    
    @IBAction func equpiedKitchenClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_INTERIORS_ARRAY] = sender.isSelected ? Strings.EQUIPPED_KITCHEN as AnyObject : "" as AnyObject
    }
    
    @IBAction func gymClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_INTERIORS_ARRAY] = sender.isSelected ? Strings.GYM as AnyObject : "" as AnyObject
    }
    
    @IBAction func laundryClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_INTERIORS_ARRAY] = sender.isSelected ? Strings.LAUNDRY as AnyObject : "" as AnyObject
    }
    
    @IBAction func mediaRoomClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_INTERIORS_ARRAY] = sender.isSelected ? Strings.MEDIA_ROOM as AnyObject : "" as AnyObject
    }
    
    @IBAction func backyardClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OUTDOORS_ARRAY] = sender.isSelected ? Strings.BACK_YARD as AnyObject : "" as AnyObject
    }
    
    @IBAction func basketballCourtClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OUTDOORS_ARRAY] = sender.isSelected ? Strings.BASKETBALL_COURT as AnyObject : "" as AnyObject
    }
    
    @IBAction func frontyardClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OUTDOORS_ARRAY] = sender.isSelected ? Strings.FRONT_YARD as AnyObject : "" as AnyObject
    }
    
    @IBAction func garageAttachedClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OUTDOORS_ARRAY] = sender.isSelected ? Strings.GARAGE_ATTACHED as AnyObject : "" as AnyObject
    }
    
    @IBAction func hotBathClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OUTDOORS_ARRAY] = sender.isSelected ? Strings.HOT_BATH as AnyObject : "" as AnyObject
    }
    
    @IBAction func poolClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OUTDOORS_ARRAY] = sender.isSelected ? Strings.POOL as AnyObject : "" as AnyObject
    }
    
    @IBAction func centralAirClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_UTILITIES_ARRAY] = sender.isSelected ? Strings.CENTRAL_AIR as AnyObject : "" as AnyObject
    }
    
    @IBAction func electricityClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_UTILITIES_ARRAY] = sender.isSelected ? Strings.ELECTRICITY as AnyObject : "" as AnyObject
    }
    
    @IBAction func heatingClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_UTILITIES_ARRAY] = sender.isSelected ? Strings.HEATING as AnyObject : "" as AnyObject
    }
    
    @IBAction func naturalGasClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_UTILITIES_ARRAY] = sender.isSelected ? Strings.NATURAL_GAS as AnyObject : "" as AnyObject
    }
    
    @IBAction func ventilationClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_UTILITIES_ARRAY] = sender.isSelected ? Strings.VENTILATION as AnyObject : "" as AnyObject
    }
    
    @IBAction func waterClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_UTILITIES_ARRAY] = sender.isSelected ? Strings.WATER as AnyObject : "" as AnyObject
    }
    
    @IBAction func chairAccessibleClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OTHER_FEATURES_ARRAY] = sender.isSelected ? Strings.CHAIR_ACCESSIBLE as AnyObject : "" as AnyObject
    }
    
    @IBAction func elevatorClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OTHER_FEATURES_ARRAY] = sender.isSelected ? Strings.ELEVATOR as AnyObject : "" as AnyObject
    }
    
    @IBAction func fireplaceClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OTHER_FEATURES_ARRAY] = sender.isSelected ? Strings.FIRE_PLACE as AnyObject : "" as AnyObject
    }
    
    @IBAction func smokeDetectorsClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OTHER_FEATURES_ARRAY] = sender.isSelected ? Strings.SMOKE_DETECTORS as AnyObject : "" as AnyObject
    }
    
    @IBAction func washerAndDryerClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OTHER_FEATURES_ARRAY] = sender.isSelected ? Strings.WATER_AND_DRYER as AnyObject : "" as AnyObject
    }
    
    @IBAction func wifiClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        finalParam[WSRequestParams.WS_REQS_PARAM_OTHER_FEATURES_ARRAY] = sender.isSelected ? Strings.WIFI as AnyObject : "" as AnyObject
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
        WSManager.wsCallAddProperty(AddProperty.unitParams ?? [:], AddProperty.imageData ?? []) { isSuccess, message in
            Helper.hideLoader(onVC: self)
            
            if isSuccess {
                for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) {
                    if controller.isKind(of: AgentDashboardViewController.self) {
                        self.navigationController?.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
            else {
                Helper.showOKAlert(onVC: self, title: message, message: "")
            }
        }
    }
}
