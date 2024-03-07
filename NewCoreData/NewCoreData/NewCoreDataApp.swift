//
//  NewCoreDataApp.swift
//  NewCoreData
//
//  Created by Pabita Pun on 2024-03-06.
//

import SwiftUI

@main
struct NewCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
