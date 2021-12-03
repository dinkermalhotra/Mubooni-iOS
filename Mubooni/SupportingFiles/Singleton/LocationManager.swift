import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
        
    private override init() {}
    
    let locationManager = CLLocationManager()
    var onCompletion: ((_ latitude: String, _ longitude: String, _ address: String) -> Void)?
    
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
        let latitude = "\(userLocation.coordinate.latitude)"
        let longitude = "\(userLocation.coordinate.longitude)"
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if let error = error {
                print("error in reverseGeocode")
                address = error.localizedDescription
            }
            else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    address = "\(placemark.thoroughfare ?? "") \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
                } else {
                    address = "No Matching Addresses Found"
                }
                
                if let block = self.onCompletion {
                    block(latitude, longitude, address)
                }
                
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
}