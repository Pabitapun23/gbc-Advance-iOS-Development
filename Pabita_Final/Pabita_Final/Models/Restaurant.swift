//
//  Restaurant.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import Foundation

struct Restaurant : Codable, Hashable {
    var id : UUID = UUID()
    var name: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    init() {
        
    }
    
    init(name: String, lat: Double, lng: Double) {
        self.name = name
        self.lat = lat
        self.lng = lng
    }
}
