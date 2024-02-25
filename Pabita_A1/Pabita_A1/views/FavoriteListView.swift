//
//  FavoriteListView.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import SwiftUI

struct FavoriteListView: View {
    
    @State private var favCountryList: [Country] = []
    @State private var showAlert = false
    @State private var countryToDelete: Country?
    @State private var deletionIndexSet: IndexSet?
    
    private let fireDBHelper = FireDBHelper.getInstance()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(favCountryList) { currentCountry in
                        NavigationLink(destination: CountryDetailsView(country: currentCountry).environmentObject(self.fireDBHelper)) {
                            VStack(alignment: .leading){
                                Text("\(currentCountry.name.common)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)

                                if let capital = currentCountry.capital?.first {
                                    Text("Capital: \(capital)")
                                        
                                }
                            }
                        } // NavigationLink
                    } // ForEach
                    .onDelete(perform: confirmDeleteCountry)
                } // List
                
                Spacer()
            } // VStack
            .navigationTitle("Favorite List")
            .onAppear {
                self.fireDBHelper.getAllFavCountries()
            }
            .onReceive(self.fireDBHelper.$favCountryList) { favCountries in
                // Update favCountryList when the data changes
                self.favCountryList = favCountries
           }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete this country from favorites?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let indexSet = deletionIndexSet {
                            deleteCountry(at: indexSet)
                        }
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            } // alert
        } // NavigationStack
    } // body
    
    private func confirmDeleteCountry(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        countryToDelete = favCountryList[index]
        showAlert = true
        deletionIndexSet = indexSet
    } // func
    
    private func deleteCountry(at offsets: IndexSet) {
        for index in offsets {
            let countryToDelete = favCountryList[index]
            print("Country to delete: \(countryToDelete.name.common)")
            fireDBHelper.deleteCountryFromFavList(countryToDelete: countryToDelete)
            favCountryList.remove(at: index)
        } // for
    } // func
                
}

#Preview() {
    FavoriteListView()
}
