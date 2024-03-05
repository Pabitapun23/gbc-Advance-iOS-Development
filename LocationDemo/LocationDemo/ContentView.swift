//
//  ContentView.swift
//  LocationDemo
//
//  Created by Pabita Pun on 2024-03-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // adding three tabs
            ForwardGeoView()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Forward Geo")
                } // .tabItem
            
            ReverseGeoView()
                .tabItem {
                    Image(systemName: "location.circle.fill")
                    Text("Reverse Geo")
                } // .tabItem
            
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                } // .tabItem
        } // TabView
    } // body
}

#Preview {
    ContentView()
}
