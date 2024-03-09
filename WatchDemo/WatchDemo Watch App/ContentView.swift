//
//  ContentView.swift
//  WatchDemo Watch App
//
//  Created by Pabita Pun on 2024-03-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("WatchActivity Screen")
            }
            .padding()
            .navigationTitle("Pabita")
        }
    }
}

#Preview {
    ContentView()
}
