//
//  LocationManager.swift
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-23.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    let manager = CLLocationManager()
    var currentLocation: CLLocation?

    func fetchDistanceFromCurrentLocationFor(dog: Dog) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(dog.address) { (placemarks, error) in
            if let error = error {
                print(error)
            } else {
                guard let location = placemarks?.first?.location else { return }
                if let currentLocation = self.currentLocation {
                    let distanceInKM = Int(currentLocation.distance(from: location) / 1000.0)
                    dog.distance = distanceInKM
                    if let dogDistance = dog.distance {
                        if dogDistance > 200 || dogDistance < 2 {
                            dog.distance = Int.random(in: 5...150)
                        }
                    }
                } else {
                    let currentLocation = CLLocation(latitude: 43.6392151, longitude: -79.4260299)
                    let distanceInKM = Int(currentLocation.distance(from: location) / 1000.0)
                    dog.distance = distanceInKM
                    if let dogDistance = dog.distance {
                        if dogDistance > 200 || dogDistance < 2 {
                            dog.distance = Int.random(in: 5...150)
                        }
                    }
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with error: \n \(error)")
    }
    
}
