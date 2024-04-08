//
//  LocationHelper.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import Foundation
import CoreLocation
import Contacts

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    private let geoCoder = CLGeocoder()
    // An interface for converting between geographic coordinates and place names.
    
    private let locationManager = CLLocationManager()
    //The object that you use to start and stop the delivery of location-related events to your app.
    
    // convert coordinates to address
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
                    
                } // placemarkList
            } // if-else
            
        }) // geoCoder.reverseGeocodeLocation
    } // func

}
