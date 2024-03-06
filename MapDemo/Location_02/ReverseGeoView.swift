//
//  ReverseGeoView.swift
//  Location_02
//
//  Created by Pedram Faghihi on 2024-03-04.
//

import SwiftUI
import CoreLocation

struct ReverseGeoView: View {
    // declare the var for Lat / Long / results
    @State private var tfLat : String = ""
    @State private var tfLng : String = ""
    @State private var result : String = ""
    
    // env object
    @EnvironmentObject var locationHelper: LocationHelper
    
    
    var body: some View {
        VStack{
            Text("Reverse Geocoding")
            Form{
                // textfields
                TextField("Enter Lat", text: $tfLat)
                TextField("Enter Lng", text: $tfLng)
                
            }//form
            //results
            Text("\(self.result)")
            
            //Button calling doReverseGeocoding()
            Button(action: {
                // call doReverseGeocoding()
                self.doReverseGeocoding()
            }){
                Text("Reverse Geocoding")
            }
        }//Vstack
        
    }//body
    
    private func doReverseGeocoding(){
        print("performing reverse geocoding")
        guard let lat = Double(self.tfLat) else{
            return
        }
        guard let lng = Double(self.tfLng) else{
            return
        }
        
        let inputLocation = CLLocation(latitude: lat, longitude: lng)
       
        // call 
        self.locationHelper.doReverseGeocoding(location: inputLocation, completionHandler: {
            (matchingAddress, error) in
            
            if (error == nil && matchingAddress != nil){
                self.result = matchingAddress!
            }else{
                self.result = "Unable to obtain address for given coordinates"
            }
        })
    }
    
}//View

#Preview {
    ReverseGeoView()
}
