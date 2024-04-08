//
//  CoreRelatApp.swift
//  CoreRelat
//
//  Created by Pedram Faghihi on 2024-03-11.
//

import SwiftUI

@main
struct CoreRelatApp: App {
    @StateObject var dataController : DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }

    var body: some Scene {
        WindowGroup {
            ParentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
