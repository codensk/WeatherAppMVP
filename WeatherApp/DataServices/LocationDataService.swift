//
//  LocationDataService.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 27.05.2021.
//

import Foundation
import CoreLocation

protocol LocationDataServiceDelegate {
    func didUpdateLocations(_ coordinates: CLLocationCoordinate2D)
}

class LocationDataService: NSObject {
    // MARK: - Properties
    var delegate: LocationDataServiceDelegate?
    private var locationManager: CLLocationManager!
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    // MARK: - Methods
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
}

// MARK: - Extensions
extension LocationDataService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        if let delegate = delegate {
            delegate.didUpdateLocations(userLocation.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
