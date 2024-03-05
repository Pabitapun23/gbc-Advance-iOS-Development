//
//  ForwardGeoView.swift
//  LocationDemo
//
//  Created by Pabita Pun on 2024-03-04.
//

import SwiftUI

struct ForwardGeoView: View {
    
    @State private var tfStreet : String = ""
    @State private var tfCity : String = ""
    @State private var tfCountry : String = ""
    @State private var result : String = ""
    
    // Observable Object - locationHelper
    @EnvironmentObject var locationHelper : LocationHelper
    
    var body: some View {
        VStack {
            Form {
                TextField("Enter Street", text: $tfStreet)
                TextField("Enter City", text: $tfCity)
                TextField("Enter Country", text: $tfCountry)

            } // Form
            Text("\(self.result)")
            
            Button(action: {
                let address = "\(self.tfStreet), \(self.tfCity), \(self.tfCountry)"
                
                // do GeoCoding()
                self.doGeoCoding(address: address)
                
            }, label: {
                Text("Forward Geocoding")
                
            }) // Button
            .padding(.horizontal, 15.0)
            .padding(.vertical, 10.0)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(8.0)
            
            Spacer()
            
        } // VStack
        
    } // body
    
    private func doGeoCoding(address: String) {
        print(#function, "Performing geocoding on address: \(address)")
        
        // call the helper function
        self.locationHelper.doForwardGeoCoding(address: address, completionHandler: {
            (coordinates, error) in
            if(error == nil && coordinates != nil) {
                self.result = "Lat: \(coordinates?.coordinate.latitude) \n Lng: \(coordinates?.coordinate.longitude)"
            } else {
                self.result = "Coordinates for the address is not available"
            }
        })
    }
}

#Preview {
    ForwardGeoView()
}
