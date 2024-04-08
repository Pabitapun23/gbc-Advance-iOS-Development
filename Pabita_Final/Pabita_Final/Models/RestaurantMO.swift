//
//  RestaurantMO.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import Foundation
import CoreData

@objc(RestaurantMO)
final class RestaurantMO: NSManagedObject {
    @NSManaged var id : UUID?
    @NSManaged var name: String
    @NSManaged var lat: Double
    @NSManaged var lng: Double
}

extension RestaurantMO {
    
    func displayRestaurant() {
        print(#function, "Restaurant info")
    }
}
