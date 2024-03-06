//
//  LocationHelper.swift
//  Location_02
//
//  Created by Pedram Faghihi on 2024-03-04.
//

import Foundation
import CoreLocation
import Contacts

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate{
    // ObservableObject: Combine framework’s type for an object with a publisher that emits before the object has changed.
    // The methods that you use to receive events from an associated location-manager object.
    
    private let geoCoder = CLGeocoder()
    // An interface for converting between geographic coordinates and place names.
    
    private let locationManager = CLLocationManager()
    //The object that you use to start and stop the delivery of location-related events to your app.
    
    @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
    // Constants indicating the app's authorization to use location services.
    
    @Published var currentLocation: CLLocation?
    //The latitude, longitude, and course information reported by the system.
    
    override init() {
        super.init()
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //The best level of accuracy available.
            
        }
        // permission check
        self.checkPermission()
        
        if (CLLocationManager.locationServicesEnabled() && (self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        }else{
            self.requestPermission()
        }
        
    }// init
    
    func requestPermission(){
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
            //Requests the user’s permission to use location services while the app is in use.
        }
    }
    
    
    func checkPermission(){
        switch self.locationManager.authorizationStatus{
        case .denied:
            // req perm
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
    }//checkPerm
    
    // ******

   
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status changed : \(self.locationManager.authorizationStatus)")
        
        self.authorizationStatus = manager.authorizationStatus
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //process received locations
        
        if locations.last != nil{
            //most recent
            print(#function, "most recent location : \(locations.last!)")
            
            self.currentLocation = locations.last!
        }else{
            //oldest known location
            print(#function, "last known location : \(locations.first)")
            
            self.currentLocation = locations.first
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Error while trying to get location updates : \(error)")
    }
    
    deinit{
        self.locationManager.stopUpdatingLocation()
    }
    
    
    
    
    //******
    
    // convert address to coordinates
    func doForwardGeocoding(address : String, completionHandler: @escaping(CLLocation?, NSError?) -> Void){
        self.geoCoder.geocodeAddressString(address, completionHandler: {
            (placemarks, error) in
            if (error != nil){
                print(#function, "Unable to obtain coord for the given address \(error)")
                completionHandler(nil, error as NSError?)
            }else{
                if let place = placemarks?.first{
                    let matchedLocation = place.location!
                    print(#function, "matchedLocation: \(matchedLocation)")
                    completionHandler(matchedLocation, nil)
                    return
                }
                completionHandler(nil, error as NSError?)
            }
        })
    }//doforward()
    
    // coordinates > address
    func doReverseGeocoding(location: CLLocation, completionHandler: @escaping(String?, NSError?) -> Void){
        self.geoCoder.reverseGeocodeLocation(location
        , completionHandler: {
            (placemarks, error) in
            
            if(error != nil){
                print(#function, "Unable to obtain street address for the given coordinates \(error)")
                
                completionHandler(nil, error as NSError?)
            }else{
                if let placemarkList = placemarks, let firstPlace = placemarks?.first{
                    // get street address from coordinates
                    
                    let street = firstPlace.thoroughfare ?? "NA"
                    let postalCode = firstPlace.postalCode ?? "NA"
                    let country = firstPlace.country ?? "NA"
                    let province = firstPlace.administrativeArea ?? "NA"
                    
                    print(#function, "\(street), \(postalCode), \(country), \(province)")
                    
                    //An object that you use to format a contact's postal addresses.
                    let address = CNPostalAddressFormatter.string(from: firstPlace.postalAddress!, style: .mailingAddress)
                    
                    completionHandler(address, nil)
                    return
                    
                }
            }
            
        })
    }
    
    
    
    
    
    
}
