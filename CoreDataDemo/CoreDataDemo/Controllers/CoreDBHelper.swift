//
//  CoreDBHelper.swift
//  CoreDataDemo
//
//  Created by J Patel on 2024-03-06.
//

import Foundation
import CoreData

//MVC - Controller

class CoreDBHelper : ObservableObject{
    
    @Published var bookList = [BookMO]()
    
    //singleton instance
    private static var shared: CoreDBHelper?
    private let ENTITY_NAME = "BookMO"
    private let moc : NSManagedObjectContext
    
    static func getInstance() -> CoreDBHelper{
        if shared == nil{
            shared = CoreDBHelper(moc: PersistenceController.preview.container.viewContext)
        }
        
        return shared!
    }
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func insertBook(newBook: Book){
        do{
            // obtain the object reference of NSEntityDescription
            let bookToInsert = NSEntityDescription.insertNewObject(forEntityName: self.ENTITY_NAME, into: self.moc) as! BookMO
            
            // assign the values to object reference
            bookToInsert.title = newBook.title
            bookToInsert.author = newBook.author
            bookToInsert.isFiction = newBook.isFiction
            bookToInsert.dateAdded = Date()
            bookToInsert.id = UUID()
            
            // save the object to db
            if self.moc.hasChanges {
                try self.moc.save()
                
                print(#function, "Book successfully saved to db")
            }

        }catch let error as NSError{
            print(#function, "Could not insert book successfully \(error)")
        }
    }

    func getAllBooks(){

        let request = NSFetchRequest<BookMO>(entityName: self.ENTITY_NAME)
        request.sortDescriptors = [NSSortDescriptor.init(key: "title", ascending: true)]
        
//        predicate - filtering criteria , %@ - placeholder (something)
//        let titleToSearch = "Alchemist"
//        let authorToSearch = "Coelho"
//        let titlePredicate = NSPredicate(format: "title == %@", titleToSearch as CVarArg)
//        let authorPredicate = NSPredicate(format: "author == %@", authorToSearch as CVarArg)
//        request.predicate = titlePredicate
//        request.predicate = authorPredicate
        
        do{
            let result = try self.moc.fetch(request)
            
            print(#function, "\(result.count) books fetched from db")
            
            self.bookList.removeAll()
            self.bookList.insert(contentsOf: result, at: 0)

        }catch let error as NSError{
            print(#function, "Couldn't fetch data from DB \(error)")
        }
    }
    
//    private func searchBook(bookID : UUID) -> BookMO?{
//
//        do{
//
//
//        }catch let error as NSError{
//            print(#function, "Unable to search for given ID \(error)")
//        }
//
//        return nil
//    }

    func deleteBook(bookToDelete : BookMO){

            do{
                self.moc.delete(bookToDelete)
                try self.moc.save()
                print(#function, "Book deleted successfully")
                self.getAllBooks()

            }catch let error as NSError{
                print(#function, "Unable to delete given bookID \(error)")
            }

    }

    func updateBook(){
        
        do{
            try self.moc.save()
            print(#function, "Book details are updated successfully")
            self.getAllBooks()

        }catch let error as NSError{
            print(#function, "Unable to search for given bookID \(error)")
        }

    } // func - updateBook()
    

}
