//
//  Pabita_A1App.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
struct Pabita_A1App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
