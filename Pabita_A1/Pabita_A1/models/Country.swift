//
//  Country.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import Foundation
import FirebaseFirestoreSwift

struct Country : Codable, Identifiable{
    var id : String? 
    var name : CountryName
    var capital : [String]?
    var region : Region
    var flags : Flags
    var population : Int
    
    init(name: CountryName, capital: [String]? = nil, region: Region, flags: Flags, population: Int) {
        self.name = name
        self.capital = capital
        self.region = region
        self.flags = flags
        self.population = population
    }
}
