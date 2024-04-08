//
//  HomeView.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @State private var selection : Int? = nil
    @State private var selectedIndex : Int = -1
    
//    @EnvironmentObject var coreDBHelper : CoreDBHelper
    @ObservedObject var coreDBHelper = CoreDBHelper.getInstance()
    
    var body: some View {
        NavigationStack {
            VStack {
                // List of restaurants
                List{
                    ForEach(self.coreDBHelper.restaurantList.enumerated().map({$0}), id: \.element.self){index, currentRestaurant in
                        NavigationLink(destination: RestaurantDetailsView(selectedRestaurantIndex: index)){
                            VStack(alignment: .leading){
                                Text(currentRestaurant.name)
                                    .fontWeight(.bold)
                            }//VStack
                        }//NavigationLink
                    }//ForEach
                    .onDelete(perform: {indexSet in
                    })
                    
                }//List ends
      
            } // VStack
            .onAppear(){
                // fetch restaurants from Core Data when the view appears
                self.coreDBHelper.getAllRestaurants()
            }
            .navigationTitle("Restaurants")
            
        } // NavigationStack
    } // body
    
}

#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
