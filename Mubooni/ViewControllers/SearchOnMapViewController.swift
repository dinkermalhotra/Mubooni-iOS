import UIKit
import GoogleMaps
import GooglePlaces

class SearchOnMapViewController: UIViewController {

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    var properties = [Properties]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCurrentLocation()
        
        viewSearch.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(searchClicked)))
    }

    func fetchCurrentLocation() {
        LocationManager.shared.requestLocation()
        LocationManager.shared.onCompletion = { (latitude, longitude, address) in
            Helper.showLoader(onVC: self)
            self.searchPropertiesOnMap(latitude, longitude)
        }
    }
    
    func setupMap(_ userLocation: CLLocation) {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.clear()
        mapView.camera = GMSCameraPosition(target: userLocation.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        setupLocationsOnMap()
    }
    
    func setupLocationsOnMap() {
        for property in properties {
            let location = CLLocationCoordinate2D(latitude: Double(property.latitude) ?? 0.0, longitude: Double(property.longitude) ?? 0.0)
            let marker = GMSMarker()
            marker.position = location
            marker.title = property.estateName
            marker.map = mapView
        }
    }
    
    @objc func searchClicked() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.view.tintColor = UIColor.black
        
//        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))
//        autocompleteController.placeFields = fields
//
//        let filter = GMSAutocompleteFilter()
//        filter.type = .address
//        autocompleteController.autocompleteFilter = filter
        
        autocompleteController.modalPresentationStyle = .overFullScreen
        present(autocompleteController, animated: true, completion: nil)
    }
}

// MARK: - UIBUTTON ACTIONS
extension SearchOnMapViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - GMSMAPVIEW DELEGATE
extension SearchOnMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        var row = 0
        for (index, property) in properties.enumerated() {
            if property.estateName.lowercased() == marker.title?.lowercased() {
                row = index
            }
        }
        
        if let vc = ViewControllerHelper.getViewController(ofType: .AgentPropertyDetailViewController) as? AgentPropertyDetailViewController {
            vc.property = properties[row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - GOOGLEPLACES AUTOCOMPLETE DELEGATE
extension SearchOnMapViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        Helper.showLoader(onVC: self)
        searchPropertiesOnMap(String(place.coordinate.latitude), String(place.coordinate.longitude))
        
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
extension SearchOnMapViewController {
    func searchPropertiesOnMap(_ latitude: String, _ longitude: String) {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LAT: latitude as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_LNG: longitude as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_REG_TYPE: Strings.LOCAL as AnyObject]
        WSManager.wsCallGetPropertiesOnMap(params) { isSuccess, message, properties in
            let location = CLLocation(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
            Helper.hideLoader(onVC: self)
            
            self.properties = properties ?? []
            self.setupMap(location)
        }
    }
}
