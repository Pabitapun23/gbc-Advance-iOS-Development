//
//  Pabita_FinalApp.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import SwiftUI
import CoreData
import MapKit

@main
struct Pabita_FinalApp: App {
    let coreDBHelper = CoreDBHelper(moc: PersistenceController.shared.container.viewContext)
    let locationHelper = LocationHelper()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(coreDBHelper)
                .environmentObject(locationHelper)
        }
    }
}
