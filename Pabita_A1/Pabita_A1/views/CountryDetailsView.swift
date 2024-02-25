//
//  CountryDetailsView.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import SwiftUI

struct CountryDetailsView: View {
    
    var country : Country
    @State private var showAlertCountryExists = false
    @State private var confirmationMsg : String = ""
    @State private var favCountryList: [Country] = []
    
    private let fireDBHelper = FireDBHelper.getInstance()
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // country name
            Text("Country Name : \(country.name.common)")
                .font(.title2)
                .fontWeight(.bold)
            
            // Capital
            if let capital = country.capital?.first { // Check if capital exists and get the first one if available
                            Text("Capital: \(capital)")
                    .font(.title3)
                        }
            
            // flag image
            HStack {
                Spacer()
                
                AsyncImage(url: URL(string: country.flags.png))
                
                Spacer()
            }
            
            // region
            Text("Region: \(country.region.rawValue)")
            
            // population
            Text("Population: \(country.population)")
            
            // button to mark as favorite
            HStack {
                Spacer()
                
                Button {
                    self.addCountryToFavoriteList()
                } label: {
                    Text("Mark as Favorite")
                }
                .padding(.all)
                .background(.blue)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                
                Spacer()
            } // HStack
            .padding(.vertical, 20.0)
            
            // success msg
            Text(confirmationMsg)
                .foregroundStyle(.green)
                
            
            Spacer()
        } // VStack
        .padding()
        .navigationTitle("Country Detail Page")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlertCountryExists) {
            Alert(
                title: Text("Already in Favorites"),
                message: Text("This country is already in your favorites."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            self.fireDBHelper.getAllFavCountries()
            confirmationMsg = ""
        }
        .onReceive(self.fireDBHelper.$favCountryList) { favCountries in
            // Update favCountryList when the data changes
            self.favCountryList = favCountries
       }
    } // body
    
    
    // function to add country to favorite list
    func addCountryToFavoriteList() {
        print("Adding country to favorite list")
        
        // Check if the country name is already in the favorite list
        if !self.favCountryList.contains(where: { $0.name.common == self.country.name.common }) {
            
            print("Country not in favorite list, adding...")
            
            // Creating a Country object using the data from self.country for adding it to fav list
            let favCountry = Country(
                name: self.country.name,
                capital: self.country.capital,
                region: self.country.region,
                flags: self.country.flags,
                population: self.country.population
            )
            
            // Add the country data to Firestore
            self.fireDBHelper.addCountryToFavList(newCountry: favCountry)
            confirmationMsg = "Country added to favorite list sucessfully!"
            
        } else {
            print("Country is already in favorite list")
            showAlertCountryExists = true
            confirmationMsg = ""
        }
    } // func - addCountryToFavoriteList

}


#Preview {
    CountryDetailsView(country: Country(name: CountryName.init(common: ""), capital: [""], region: Region.africa, flags: Flags.init(png: "https://flagcdn.com/w320/ck.png", svg: "https://flagcdn.com/w320/ck.png", alt: ""), population: 0))
}
