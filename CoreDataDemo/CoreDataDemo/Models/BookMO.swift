//
//  BookMO.swift
//  CoreDataDemo
//
//  Created by Pabita Pun on 2024-03-06.
//

import Foundation
import CoreData

@objc(BookMO)
final class BookMO : NSManagedObject {
    @NSManaged var id : UUID?
    @NSManaged var title : String
    @NSManaged var author : String
    @NSManaged var isFiction : Bool
    @NSManaged var dateAdded : Date
}

extension BookMO {
    
    func displayBook() {
        print(#function, "Book information")
    }
    
    func bookAvailable() -> Bool {
        // necessary operation to check if book is available
        return false
    }
}
