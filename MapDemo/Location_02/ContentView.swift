//
//  ContentView.swift
//  Location_02
//
//  Created by Pedram Faghihi on 2024-03-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            // adding three tabs
            ForwardGeoView().tabItem {
                Image(systemName: "mappin.and.ellipse")
                Text("Forward Geo")
            }
            ReverseGeoView().tabItem {
                Image(systemName: "location.circle.fill")
                Text("Reverse Geo")
            }
            MapView().tabItem {
                Image(systemName: "map.fill")
                Text("Map")
            }
        }// TabView
    }// view
}

#Preview {
    ContentView()
}
