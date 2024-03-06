//
//  Location_02App.swift
//  Location_02
//
//  Created by Pedram Faghihi on 2024-03-04.
//

import SwiftUI

@main
struct Location_02App: App {
    let locationHelper = LocationHelper()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(locationHelper)
        }
    }
}
