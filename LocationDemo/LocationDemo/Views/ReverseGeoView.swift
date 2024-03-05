//
//  ReverseGeoView.swift
//  LocationDemo
//
//  Created by Pabita Pun on 2024-03-04.
//

import SwiftUI
import CoreLocation

struct ReverseGeoView: View {
    // declare the var for Lat / Long / results
    @State private var tfLat : String = ""
    @State private var tfLng : String = ""
    @State private var results : String = ""
    
    // env object
    @EnvironmentObject var locationHelper : LocationHelper
    
    var body: some View {
        VStack {
            Text("Reverse Geocoding")
            
            Form {
                // textfields
                TextField("Enter the latitude", text: $tfLat)
                TextField("Enter the longitude", text: $tfLng)
            } // form
            
            // results
            Text("\(self.results)")
            
            // Button calling doReverseGeoCoding()
            Button {
                let address = "\(self.tfLat) \(self.tfLng)"
                
                // call doReverGeoCoding
                
            } label: {
                Text("Reverse Geocoding")
            } // Button
            .padding(.horizontal, 15.0)
            .padding(.vertical, 10.0)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(8.0)
            
        } // VStack
        .padding()
        
        Spacer()
    } // body
    
    private func doReverseGeoCoding(address : String) {
        print(#function, "Performing geocoding on address: \(address)")
        
        guard let lat = Double(self.tfLat) else {
            return
        }
        guard let lng = Double(self.tfLng) else {
            return
        }
        
        let inputLocation = CLLocation(latitude: lat, longitude: lng)
        
        // call
        self.locationHelper.doReverseGeoCoding(location: inputLocation, completionHandler: {
            (matchingAddress, error) in
            
            if (error != nil && matchingAddress != nil) {
                self.results = matchingAddress!
            } else {
                self.results = "Unable to obtain address for given coordinates"
            }
        })
    }
}

#Preview {
    ReverseGeoView()
}
