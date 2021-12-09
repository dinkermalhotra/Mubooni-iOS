import UIKit
import DropDown
import GooglePlaces

class AddPropertyDescriptionViewController: UIViewController {

    @IBOutlet weak var txtPropertyType: UITextField!
    @IBOutlet weak var txtBuildingName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var viewProperty: UIView!
    
    var propertyDropDown = DropDown()
    var propertyTypes = [PropertyTypes]()
    var typeId = ""
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCurrentLocation()
        fetchPropertyTypes()
    }
    
    func searchAddress() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.view.tintColor = UIColor.black
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        autocompleteController.modalPresentationStyle = .overFullScreen
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func setCurrentLocation() {
        LocationManager.shared.requestLocation()
        LocationManager.shared.onCompletion = { (state, latitude, longitude, address) in
            self.txtAddress.text = address
            self.txtLatitude.text = latitude
            self.txtLongitude.text = longitude
        }
    }
    
    func setupPropertyDropDown() {
        var types = [String]()
        for i in 0..<self.propertyTypes.count {
            let dict = self.propertyTypes[i]
            
            types.append(dict.typeName)
        }
        
        self.propertyDropDown.anchorView = self.viewProperty
        self.propertyDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        self.propertyDropDown.dataSource = types
        self.propertyDropDown.backgroundColor = UIColor.white
        self.propertyDropDown.textColor = UIColor.black
        self.propertyDropDown.selectedTextColor = UIColor.black
        self.propertyDropDown.separatorColor = UIColor.clear
        self.propertyDropDown.textFont = MubooniFonts.FONT_ROBOTO_REGULAR_14 ?? UIFont.systemFont(ofSize: 14)
        self.propertyDropDown.selectionAction = { [weak self] (index, item) in
            self?.txtPropertyType.text = item
            self?.typeId = self?.propertyTypes[index].id ?? ""
        }
    }
}

// MARK: - UIBUTTON ACTIONS
extension AddPropertyDescriptionViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyMediaViewController) as? AddPropertyMediaViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension AddPropertyDescriptionViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtPropertyType {
            if propertyDropDown.isHidden == true {
                propertyDropDown.show()
            }
            else {
                propertyDropDown.hide()
            }
            
            return false
        }
        else if textField == txtAddress {
            searchAddress()
            
            return false
        }
        else {
            return true
        }
    }
}

// MARK: - GOOGLEPLACES AUTOCOMPLETE DELEGATE
extension AddPropertyDescriptionViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        txtAddress.text = place.name ?? ""
        txtLatitude.text = "\(place.coordinate.latitude)"
        txtLongitude.text = "\(place.coordinate.longitude)"
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - API CALL
extension AddPropertyDescriptionViewController {
    func fetchPropertyTypes() {
        WSManager.wsCallGetPropertyTypes { isSuccess, message, response in
            if isSuccess {
                self.propertyTypes = response ?? []
                self.setupPropertyDropDown()
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
}
