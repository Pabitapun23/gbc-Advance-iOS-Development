//
//  HomeView.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import SwiftUI

struct HomeView: View {
    
    @State var countryList : [Country] = []
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach (countryList, id: \.name.common) { currCountry in
                       
                        NavigationLink(destination: CountryDetailsView(country: currCountry)) {
                            Text (currCountry.name.common)
                        }
                    } // ForEach
                    
                } // List
                
                Spacer()
            } // VStack
            .navigationTitle("Country List")
        } // NavigationStack
        .onAppear() {
            
            // Getting country data from API
            APIManager.shared.fetchCountries { countries in
                DispatchQueue.main.async {
                    self.countryList = countries
                }
            }
        }
        
    } // body
    
}

#Preview {
    HomeView()
}
