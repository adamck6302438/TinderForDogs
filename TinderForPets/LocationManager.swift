//
//  LocationManager.swift
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-23.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit
import CoreLocation

@objcMembers class LocationManager: NSObject {
    
    static let shared = LocationManager()
    let manager = CLLocationManager()
    var currentLocation: CLLocation?
    


    func fetchDistanceFromCurrentLocationFor(dog: Dog) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(dog.address) { (placemarks, error) in
            
            if let error = error {
                print("Location Error: \(error)")
            } else {
                
                guard let location = placemarks?.first?.location else { return }
                
                if let currentLocation = self.currentLocation {
                    let distanceInKM = Int(currentLocation.distance(from: location) / 1000.0)
                    dog.distance = String(distanceInKM)
                }
                
            }
        }
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            NetworkManager.shared().fetchDogData(with: location)

    
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with error: \n \(error)")
    }
    
}
