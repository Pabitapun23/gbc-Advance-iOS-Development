//
//  LocationHelper.swift
//  LocationDemo
//
//  Created by Pabita Pun on 2024-03-04.
//

import Foundation
import CoreLocation

// ObservableObject: Combine framework's type for an object with a publisher that emits before the object has changed.
// The methods that you use to receive events from an associated location-manager object.
class LocationHelper : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // An interface for converting between geographic coordinates and place names.
    private let geoCoder = CLGeocoder()
    
    // The object that you use to start and stop the delivery of location-related events to your app.
    private let locationManager = CLLocationManager()
    
    // Constants indicating the app's authorization to use location services.
    @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
    
    // The latitude, longitude, and course information reported by the system.
    @Published var currentLocation: CLLocation?
    
    override init() {
        super.init()
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            // The best level of accuracy available.
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
        }
        
        // permission check
        self.checkPermission()
        
        if (CLLocationManager.locationServicesEnabled() && (self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)) {
            self.locationManager.startUpdatingLocation()
        } else {
            self.requestPermission()
        }
        
    } // init
    
    func requestPermission() {
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.requestWhenInUseAuthorization()
            // Requests the User's permission to use location services while the app is in use.
        }
    }
    
    func checkPermission() {
        switch self.locationManager.authorizationStatus {
        case .denied:
            // request permission
            self.requestPermission()
            
        case .notDetermined:
            self.requestPermission()
            
        case .restricted:
            self.requestPermission()
            
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            
        default:
            break
            
        }
    } // func-checkPermision
    
    // convert address to coordinates
    func doForwardGeoCoding(address: String, completionHandler: @escaping(CLLocation?, NSError?) -> Void) {
        self.geoCoder.geocodeAddressString(address, completionHandler: {
            (placemarks, error) in
            if (error != nil) {
                print(#function, "Unable to obtain coordinate for the given address \(error)")
                completionHandler(nil, error as NSError?)
            } else {
                if let place = placemarks?.first {
                    let matchedLocation = place.location!
                    print(#function, "matchedLocation: \(matchedLocation)")
                    completionHandler(matchedLocation, nil)
                    return
                }
                completionHandler(nil, error as NSError?)
            }
        })
    } // func-doForwardGeoCoding
    
    // coordinates > address
    func doReverseGeoCoding(location: CLLocation, completionHandler: @escaping(String?, NSError?) -> Void) {
        self.geoCoder.reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in
            
            if (error != nil) {
                print(#function, "Unable to obtain street address for the given coordinates \(error)")
                
                completionHandler(nil, error as NSError?)
            } else {
                if let placemarkList = placemarks, let firstPlace = placemarks?.first {
                    // get street address from coordinates
                    
                    let street = firstPlace.thoroughfare ?? "NA"
                    let postalCode = firstPlace.postalCode ?? "NA"
                    let country = firstPlace.country ?? "NA"
                    let province = firstPlace.administrativeArea ?? "NA"
                    
                    print(#function, "\(street), \(postalCode), \(country), \(province)")
                    
                    
                    let address = CNPostalAddressFormatter.string(from: firstPlace.postalAddress!, style: .mailingAddress)
                    
                    completionHandler(address, nil)
                    return
                }
            }
        })
    }
}
