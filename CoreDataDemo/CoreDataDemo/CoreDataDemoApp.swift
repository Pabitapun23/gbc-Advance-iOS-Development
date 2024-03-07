//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by J Patel on 2021-09-29.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    
    let coreDBHelper = CoreDBHelper(moc: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(coreDBHelper)
        }
    }
}
