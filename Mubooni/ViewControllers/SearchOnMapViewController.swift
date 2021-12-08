import UIKit
import GoogleMaps

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
        LocationManager.shared.onCompletion = { (state, latitude, longitude, address) in
            Helper.showLoader(onVC: self)
            self.searchPropertiesOnMap(latitude, longitude)
        }
    }
    
    func setupMap(_ userLocation: CLLocation) {
        mapView.isMyLocationEnabled = true
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
        
    }
}

// MARK: - UIBUTTON ACTIONS
extension SearchOnMapViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
