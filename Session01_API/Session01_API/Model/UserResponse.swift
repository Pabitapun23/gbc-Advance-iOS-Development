//
//  UserResponse.swift
//  Session01_API
//
//  Created by Pabita Pun on 2024-02-20.
//

import Foundation

struct Geo: Codable {
    var lat: String
    var lng: String
}

struct Address: Codable {
    var city: String
    var geo: Geo
}

struct Company: Codable {
    var name: String
    var bs: String
}

struct User: Codable {
    var id: Int
    var name: String
    var email: String
    var address: Address
    var company: Company
}
