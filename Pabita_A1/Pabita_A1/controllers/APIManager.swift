//
//  APIManager.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
        let countryDataAddress = "https://restcountries.com/v3.1/all"
        
        func fetchCountries(completion: @escaping ([Country]) -> Void) {
            guard let countryApiURL = URL(string: countryDataAddress) else {
                print("Invalid URL")
                return
            }
            
            print("URL \(countryApiURL)")

            let task = URLSession.shared.dataTask(with: countryApiURL) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(countries)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
}
