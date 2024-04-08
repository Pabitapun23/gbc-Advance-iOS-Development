//
//  RestaurantDetailsView.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import SwiftUI
import MapKit
import CoreLocation

struct RestaurantDetailsView: View {
    
    // env object
    @EnvironmentObject var coreDBHelper: CoreDBHelper
    @EnvironmentObject var locationHelper: LocationHelper
    
    let selectedRestaurantIndex : Int
    @State private var selectedRestaurantLocation: CLLocation? // Location of the selected restaurant
    @State var restaurantAddress: String = ""
    @State var restaurantName: String = ""
    
    var body: some View {
        
        VStack {
            
            // Restaurant name
            
            HStack {
                Text("Restaurant Name:")
                    .bold()
                Text(self.restaurantName)
                    .foregroundStyle(.orange)
                Spacer()
            } // HStack
            .padding(.horizontal)
            
            if let location = selectedRestaurantLocation {
                // MapView
                MapView(location: location, restaurantAddress: restaurantAddress)
                    .padding()
            } else {
                Text("No location available")
            } // if-else
            
            Spacer()
        } // VStack
        .navigationTitle("Restaurant Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            coreDBHelper.getAllRestaurants()
            
            // Load location of the selected restaurant
            self.loadSelectedRestaurant()
                        
            // reverse geocoding
            self.doReverseGeocoding()
        }
    } // body
    
    // fun for loading selected restaurant for name and location
    private func loadSelectedRestaurant() {
        guard selectedRestaurantIndex < coreDBHelper.restaurantList.count else {
            print("Error: Invalid selectedRestaurantIndex")
            return
        } // guard-else
        
        // Update restaurant name
        restaurantName = coreDBHelper.restaurantList[selectedRestaurantIndex].name
        
        self.selectedRestaurantLocation = CLLocation(latitude: coreDBHelper.restaurantList[selectedRestaurantIndex].lat, longitude: coreDBHelper.restaurantList[selectedRestaurantIndex].lng)
    } // func - loadSelectedRestaurantLocation()
    
    
    // func for doing reverseGeoCoding
    private func doReverseGeocoding() {
        print("performing reverse geocoding")
        
        print(selectedRestaurantIndex)
        
        print(coreDBHelper.restaurantList.count)
        
        // Ensure selectedRestaurantIndex is valid
        guard selectedRestaurantIndex < coreDBHelper.restaurantList.count else {
            print("Error: Invalid selectedRestaurantIndex")
            return
        } // guard-else
        
        let inputLocation = CLLocation(latitude: coreDBHelper.restaurantList[selectedRestaurantIndex].lat, longitude: coreDBHelper.restaurantList[selectedRestaurantIndex].lng)
       
        // Call reverse geocoding method from LocationHelper
        self.locationHelper.doReverseGeocoding(location: inputLocation) { (matchingAddress, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.restaurantAddress = "Error: \(error.localizedDescription)"
                } else if let matchingAddress = matchingAddress {
                    self.restaurantAddress = matchingAddress
                } else {
                    self.restaurantAddress = "Unable to obtain address for given coordinates"
                } // if-let
            } // DispatchQueue
        }
    } // func - doReverseGeocoding()
            
}

#Preview {
    RestaurantDetailsView(selectedRestaurantIndex: 0)
}


