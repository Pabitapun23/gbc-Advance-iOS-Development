//
//  ContentView.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        VStack {
            TabView {
                NavigationView {
                    HomeView()
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Countries")
                }
                
                NavigationView {
                    FavoriteListView()
                }
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            } // TabView
        } // VStack
    } // body
}

#Preview {
    ContentView()
}
