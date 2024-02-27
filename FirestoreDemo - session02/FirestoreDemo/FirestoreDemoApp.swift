//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by J Patel on 2024-02-21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
struct FirestoreDemoApp: App {
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
