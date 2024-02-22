import SwiftUI

struct ContentView: View {
    
    @State var recipesList:[Recipe] = []
    
    var body: some View {
        VStack {
            // make a button
            // when person presssed the button
            // connect to api and display the data
            // in the console
            Text("API Demo")
            Button {
                // code to connect to api
                loadDataFromAPI()
            } label: {
                Text("Get Data!")
            }
            
            // list to display data
            List {
//                 loop through each item in your datasource
//                 .id = the id property in the User struct
//                 this is the property that uniquey identifies each object
                ForEach(recipesList, id:\.idMeal) {
                    currRecipe in
                    // UI for each row
                    HStack {
                        Text(currRecipe.recipeName)
                        Spacer()
                        Text(currRecipe.recipeType)
                    }
                    Text(currRecipe.instructions)
                    AsyncImage(url:URL(string:currRecipe.image))
                }
                
            }
        }
        .padding()
        .onAppear {
            // lifecycle funciton that executes
            // when the screen loads
            loadDataFromAPI()
        }
    }   // end body
    
    func loadDataFromAPI() {
        print("Getting data from API")
        
        let websiteAddress:String
            = "https://www.themealdb.com/api/json/v1/1/search.php?f=a"
        
        guard let apiURL = URL(string: websiteAddress) else {
            print("ERROR: Cannot convert api address to an URL object")
            return
        }
        
        let request = URLRequest(url:apiURL)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response, error:Error?) in

   
            if let error = error {
                print("ERROR: Network error: \(error)")
                return
            }
            

            if let jsonData = data {
                print("data retreived")
                if let decodedResponse
                    = try? JSONDecoder().decode(MealsReponseObj.self, from:jsonData) {
                    // if conversion successful, then output it to the console
                    DispatchQueue.main.async {
                        print(decodedResponse)          // MealsResponseObj
                        // recipes
                        var recipes = decodedResponse.meals
                        
                        self.recipesList = recipes
                        
                    }
                }
                else {
                    print("ERROR: Error converting data to JSON")
                }
            }
            else {
                print("ERROR: Did not receive data from the API")
            }
        }
        task.resume()

        
    }
} // end ContentView struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
