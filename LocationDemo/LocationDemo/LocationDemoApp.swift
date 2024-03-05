//
//  LocationDemoApp.swift
//  LocationDemo
//
//  Created by Pabita Pun on 2024-03-04.
//

import SwiftUI

@main
struct LocationDemoApp: App {
    let locationHelper = LocationHelper()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(locationHelper)
        }
    }
}
