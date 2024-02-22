//
//  UserView.swift
//  Session01_API
//
//  Created by Pabita Pun on 2024-02-20.
//

import SwiftUI

struct UserView: View {
    
    @State var userList:[User] = []
    
    var body: some View {
        VStack {
            Text("User data")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            // Make a button, once we press the button that'll connect to api and display data
            Button {
                // todo: Load data from API
//                loadDataFromAPI()
            } label: {
                Text("Get Data")
            } // button
            
            // list to display data

            List {
                ForEach(userList, id: \.id) {
                    currUser in
                    HStack {
                        Text("Name: \(currUser.name)")
                        Text("Email: \(currUser.email)")
                    }
                    Text("Adress: \n City: \(currUser.address.city) \n lat: \(currUser.address.geo.lat) \n lng: \(currUser.address.geo.lng)")
                    
                    Text("Company: \(currUser.company.name) \n bs: \(currUser.company.bs)")
                }
            }
            
            
            Spacer()
        } // VStack
        .padding()
        .onAppear() {
            // lifecycle function that appears
            loadDataFromAPI()
        }
    }
    
    func loadDataFromAPI() {
        print("Getting data from API...")
        
        // specify the API url
        let userDataAddress:String = "https://jsonplaceholder.typicode.com/users"
        
        // convert the string to url object
        
        guard let userApiURL = URL(string: userDataAddress) else {
            print("ERROR: cannot convert user api address to an URL object")
            return
        }
        
        // Create a network request object
        let userDataRequest = URLRequest(url: userApiURL)
        
        // use request object > connect to API > handle the results > deal with errors

        let task = URLSession.shared.dataTask(with: userDataRequest) {
            (data:Data?, response, error) in
            
            if let error = error {
                print("ERROR: Network error: \(error)")
                return
            }
            
            // checking if data retrieved
            if let jsonData = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: jsonData) {
                    DispatchQueue.main.async{
                        
                        // [Digimon]
                        print(decodedResponse)
                        
                        // update the list's data source to be the digimon
                        // from the api
                        self.userList = decodedResponse
                    }
                } else {
                    print("ERROR: converting data to JSON")
                }
            } else {
                print("ERROR: Did not receive data from API")
            }
        }
        task.resume()
    } // func
}


#Preview {
    UserView()
}
