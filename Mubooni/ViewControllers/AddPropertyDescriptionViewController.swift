import UIKit
import DropDown
import GoogleMaps
import GooglePlaces

class AddPropertyDescriptionViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtPropertyType: UITextField!
    @IBOutlet weak var txtBuildingName: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var viewProperty: UIView!
    
    var propertyDropDown = DropDown()
    var propertyTypes = [PropertyTypes]()
    var typeId = ""
    
    var _settings: SettingsManager?
    
    var settings: SettingsManagerProtocol?
    {
        if let _ = WSManager._settings {
        }
        else {
            WSManager._settings = SettingsManager()
        }

        return WSManager._settings
    }
    
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
        LocationManager.shared.onCompletion = { (latitude, longitude, address) in
            self.txtAddress.text = address
            self.txtAddress.textColor = UIColor.black
            
            self.txtLatitude.text = latitude
            self.txtLongitude.text = longitude
            
            let location = CLLocation(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
            self.setupMap(location)
        }
    }
    
    func setupMap(_ userLocation: CLLocation) {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.camera = GMSCameraPosition(target: userLocation.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        mapView.clear()
        let marker = GMSMarker(position: CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude))
        marker.map = mapView
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
            if item.lowercased() == Strings.LAND.lowercased() {
                self?.txtBuildingName.placeholder = Strings.PLOT_NUMBER
            }
            else {
                self?.txtBuildingName.placeholder = Strings.BUILDING_NAME
            }
            
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
        if txtPropertyType.text?.isEmpty ?? true || txtBuildingName.text?.isEmpty ?? true || txtAddress.text?.isEmpty ?? true || txtLatitude.text?.isEmpty ?? true || txtLongitude.text?.isEmpty ?? true {
            Helper.showOKAlert(onVC: self, title: Alert.ALERT, message: AlertMessages.ALL_FIELDS_ARE_MANDATORY)
        }
        else {
            AddProperty.address = txtAddress.text
            AddProperty.estateId = typeId
            AddProperty.estateName = txtPropertyType.text
            AddProperty.geoLocation = "\(txtLatitude.text ?? ""), \(txtLongitude.text ?? "")"
            AddProperty.userId = settings?.userProfile?.userId
            
            if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyMediaViewController) as? AddPropertyMediaViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

// MARK: - GMSMAPVIEW DELEGATE
extension AddPropertyDescriptionViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        LocationManager.shared.getUserAddress(coordinate)
        LocationManager.shared.addressCompletion = { (address) in
            self.txtAddress.text = address
            self.txtAddress.textColor = UIColor.black
        }
        
        txtLatitude.text = String(format: "%.6f", coordinate.latitude)
        txtLongitude.text = String(format: "%.6f", coordinate.longitude)
        
        mapView.clear()
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
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
//        else if textField == txtAddress {
//            searchAddress()
//
//            return false
//        }
        else {
            return true
        }
    }
}

// MARK: - UITEXTVIEW DELEGATE
extension AddPropertyDescriptionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Strings.ADDRESS {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = Strings.ADDRESS
            textView.textColor = MubooniColors.placeholderColor
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
