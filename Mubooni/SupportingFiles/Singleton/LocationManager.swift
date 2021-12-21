import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
        
    private override init() {}
    
    let locationManager = CLLocationManager()
    var onCompletion: ((_ state: String, _ latitude: String, _ longitude: String, _ address: String) -> Void)?
    
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
        var state = ""
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if let error = error {
                print("error in reverseGeocode")
                address = error.localizedDescription
            }
            else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    address = "\(placemark.thoroughfare ?? "") \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
                    state = placemark.locality ?? ""
                } else {
                    address = "No Matching Addresses Found"
                    state = "No Matching Addresses Found"
                }
                
                if let block = self.onCompletion {
                    block(state, latitude, longitude, address)
                }
                
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
}
