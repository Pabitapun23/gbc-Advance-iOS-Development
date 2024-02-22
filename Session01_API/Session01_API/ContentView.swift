//
//  ContentView.swift
//  Session01_API
//
//  Created by Pabita Pun on 2024-02-20.
//

import SwiftUI

struct ContentView: View {
    
    // data source for your list
    // it is marked as @State because its contents will change
    // when we retrieve the data from the API
    @State var digimonList:[Digimon] = [
        Digimon(name:"Peter", img:"", level:"Expert"),
        Digimon(name:"Janet", img:"", level:"Advanced")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("API Demo")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                // Make a button, once we press the button that'll connect to api and display data
                Button {
                    // todo: Load data from API
                    loadDataFromAPI()
                } label: {
                    Text("Get Data")
                } // button
                
                // list to display data
                List {
                    // loop through each item in your datasource
                    ForEach(digimonList, id:\.name) {
                        currDigimon in
                        // UI for each row
                        HStack {
                            // digimon name
                            Text("\(currDigimon.name)")
                            Spacer()
                            // digimon level
                            Text("\(currDigimon.level)")
                        }
                        AsyncImage(url:URL(string:currDigimon.img))
                        
                    }
                    
                } // List

                
                NavigationLink("User View", destination: UserView())
                
                Spacer()
            } // VStack
            .padding()

            
        }
    } // body
    
    func loadDataFromAPI() {
        print("Getting data from API...")
        
        // specify the API url
        let websiteAddress: String = "https://digimon-api.vercel.app/api/digimon"
        
        // convert the string to url object
        guard let apiURL = URL(string: websiteAddress) else {
            print("ERROR: cannot convert api address to an URL object")
            return
        }
        
        // Create a network request object
        let request = URLRequest(url: apiURL)
        
        // use request object > connect to API > handle the results > deal with errors
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response, error) in
            // checking if data retrieved
            if let jsonData = data {
                if let decodedResponse = try? JSONDecoder().decode([Digimon].self, from: jsonData) {
                    DispatchQueue.main.async{
                        
                        // [Digimon]
                        print(decodedResponse)
                        
                        // update the list's data source to be the digimon
                        // from the api
                        self.digimonList = decodedResponse
                    }
                } else {
                    print("ERROR: converting data to JSON")
                }
            } else {
                print("ERROR: ")
            }
        }
    } // func
}

#Preview {
    ContentView()
}
