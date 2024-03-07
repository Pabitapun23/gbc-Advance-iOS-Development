//
//  Persistence.swift
//  CoreDataDemo
//
//  Created by Pabita Pun on 2024-03-06.
//

import Foundation
import CoreData

struct PersistenceController {
    
    // create a singleton instance
    static let shared = PersistenceController()
    let container : NSPersistentContainer
    
    static var preview : PersistenceController = {
        // inMemory - true : data will not be save permanently
        let result = PersistenceController(inMemory : true)
        let viewContext = result.container.viewContext
        return result
    }()

    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "LibraryModel")
        
        if inMemory {
            // /dev/null - file name that doesn't store any data like a garbage bin. Device - null. Doesn't waste any memory.
            self.container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        self.container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(#function, "Unable to connect to CoreData : \(error)")
            }
        })
    } // init
    
}
