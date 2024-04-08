//
//  CoreDBHelper.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import Foundation
import CoreData
import SwiftUI

class CoreDBHelper : ObservableObject{
    
    @Published var restaurantList = [RestaurantMO]()
    
    //singleton instance
    private static var shared: CoreDBHelper?
    private let ENTITY_NAME = "RestaurantMO"
    private let moc : NSManagedObjectContext
    
    static func getInstance() -> CoreDBHelper{
        if shared == nil{
            shared = CoreDBHelper(moc: PersistenceController.shared.container.viewContext)
        } // if
        
        return shared!
    } // fun - getInstance()
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    } // init
    
    func createSampleData() {
        
        let restaurantData: [(String, Double, Double)] = [
            ("Green Basil", 43.67194509399123, 79.29481045076973),
            ("Garden State Restaurant", 43.67328970467347, 79.28743641138487),
            ("ViVetha Bistro", 43.67445500956285, 79.28192137352565),
            ("La Sala Restaurant", 43.67055563130399, 79.30038745534648),
            ("Moti Mahal", 43.672931144770516, 79.3225715402185),
            ("Uncle Betty's Diner", 43.71525069234152, 79.40050585666548)
        ]
                
        for data in restaurantData {
            var restaurant = Restaurant(name: data.0, lat: data.1, lng: data.2)
            insertRestaurant(newRestaurant: restaurant)
        } // for
        
    } // func - createSampleData()
    
    func insertRestaurant(newRestaurant: Restaurant){
        do{
            // obtain the object reference of NSEntityDescription
            let restaurantToInsert = NSEntityDescription.insertNewObject(forEntityName: self.ENTITY_NAME, into: self.moc) as! RestaurantMO
            
            // assign the values to object referencee
            restaurantToInsert.name = newRestaurant.name
            restaurantToInsert.lat = newRestaurant.lat
            restaurantToInsert.lng = newRestaurant.lng
            restaurantToInsert.id = UUID()
            
            // save the object to db
            if self.moc.hasChanges {
                try self.moc.save()
                
                print(#function, "Restaurant successfully saved to db")
            } // if

        } catch let error as NSError{
            print(#function, "Could not insert restaurant successfully \(error)")
        } // do-catch
        
    } // func - insertRestaurant
    
    func deleteAllRestaurants() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ENTITY_NAME)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try self.moc.execute(deleteRequest)
            try self.moc.save()
            print(#function, "All restaurants have been successfully deleted.")
        } catch let error as NSError {
            print(#function, "Could not delete all restaurants: \(error), \(error.userInfo)")
        } // do-catch
    } // func - deleteAllRestaurants()

    func getAllRestaurants(){
        
//        deleteAllRestaurants()
//        createSampleData()

        let request = NSFetchRequest<RestaurantMO>(entityName: self.ENTITY_NAME)
        request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        
        do{
            let result = try self.moc.fetch(request)
            
            print(#function, "\(result.count) restaurants fetched from db")
            
            self.restaurantList.removeAll()
            self.restaurantList.insert(contentsOf: result, at: 0)

        } catch let error as NSError{
            print(#function, "Couldn't fetch data from DB \(error)")
        } // do-catch
    } // func - getAllRestaurants()
}
