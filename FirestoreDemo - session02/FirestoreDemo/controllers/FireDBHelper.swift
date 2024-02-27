//
//  FireDBHelper.swift
//  FirestoreDemo
//
//  Created by J Patel on 2024-02-21.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var bookList = [Book]()
    
    private let db : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_LIBRARY : String = "User_Library"
    private let FIELD_TITLE : String = "title"
    private let FIELD_AUTHOR : String = "author"
    private let FIELD_ISFICTION : String = "isFiction"
    private let FIELD_DATE : String = "dateAdded"
    
    init(db : Firestore){
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(db: Firestore.firestore())
        }
        
        return shared!
    }
    
    
    func insertBook(newBook : Book){
        do{
            try self.db
                .collection(COLLECTION_LIBRARY)
                .addDocument(from: newBook)
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    func getAllBooks(){
        
    }
    
    func deleteBook(bookToDelete : Book){
        
    }
    
    func updateBook(bookToUpdate : Book){
        
    }
}
