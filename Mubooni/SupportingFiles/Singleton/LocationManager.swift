import Foundation
import CoreLocation
import GoogleMaps

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
        
    private override init() {}
    
    let locationManager = CLLocationManager()
    var onCompletion: ((_ latitude: String, _ longitude: String, _ address: String) -> Void)?
    var addressCompletion: ((_ address: String) -> Void)?
    
    func requestLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0] as CLLocation
        
        var address = ""
        let latitude = String(format: "%.6f", userLocation.coordinate.latitude)
        let longitude = String(format: "%.6f", userLocation.coordinate.longitude)
        let coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let error = error {
                print(error.localizedDescription)
                address = error.localizedDescription
            }
            else {
                if let result = response?.firstResult() {
                    if let lines = result.lines {
                        address = lines.joined(separator: ", ")
                                               
                        if let block = self.onCompletion {
                            block(latitude, longitude, address)
                        }
                        
                        self.locationManager.stopUpdatingLocation()
                    }
                }
            }
        }
    }
    
    func getUserAddress(_ coordinate: CLLocationCoordinate2D) {
        var address = ""
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let error = error {
                print(error.localizedDescription)
                address = error.localizedDescription
            }
            else {
                if let result = response?.firstResult() {
                    if let lines = result.lines {
                        address = lines.joined(separator: ", ")
                        
                        if let block = self.addressCompletion {
                            block(address)
                        }
                    }
                }
            }
        }
    }
}
