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
    private let COLLECTION_BOOKS : String = "Books"
    private let FIELD_TITLE : String = "title"
    private let FIELD_AUTHOR : String = "author"
    private let FIELD_ISFICTION : String = "isFiction"
    private let FIELD_DATE : String = "dateAdded"
    
    init(db : Firestore) {
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper {
        if (shared == nil) {
            shared = FireDBHelper(db: Firestore.firestore())
        }
        return shared!
    }
    
    func insertBook(newBook : Book){
        
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty) {
            print(#function, "Logged in user information not available. Can't add the book")
        } else {
            do {
                try self.db
                    .collection(COLLECTION_LIBRARY)
                    .document(loggedInUserEmail)
                    .collection(COLLECTION_BOOKS)
                    .addDocument(from: newBook)
            } catch let err as NSError {
                print(#function, "Unable to add document to firestore : \(err)")
            } // do-catch
        } // if-else
        
        
    }
    
    func getAllBooks(){
        
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty) {
            print(#function, "Logged in user information not available. Can't add the book")
        } else {
            
            self.db.collection(COLLECTION_LIBRARY)
                .document(loggedInUserEmail)
                .collection(COLLECTION_BOOKS)
                .addSnapshotListener({ (querySnapshot, error) in
                    
                    guard let snapshot = querySnapshot else {
                        print(#function, "Unable to retrieve data from firestore : \(error)")
                        return
                    }
                    
                    snapshot.documentChanges.forEach{ (docChange) in
                        
                        do {
                            
                            var book : Book = try docChange.document.data(as: Book.self)
                            book.id = docChange.document.documentID
                            
                            let matchedIndex = self.bookList.firstIndex(where: {($0.id?.elementsEqual(docChange.document.documentID))!})
                            
                            switch(docChange.type) {
                            case .added:
                                print(#function, "Document added : \(docChange.document.documentID)")
                                self.bookList.append(book)
                            case .modified:
                                // replace existing object with updated one
                                print(#function, "Document updated : \(docChange.document.documentID)")
                                if (matchedIndex != nil) {
                                    self.bookList[matchedIndex!] = book
                                }
                                
                            case .removed:
                                // remove object from index in bookList
                                print(#function, "Document removed : \(docChange.document.documentID)")
                                if (matchedIndex != nil) {
                                    self.bookList.remove(at: matchedIndex!)
                                }
                            }
                            
                        } catch let err as NSError {
                            print(#function, "Unable to convert document into swift object : \(err)")
                        }
                        
                    } // ForEach
                }) // addSnapshotListener
        }

    } // func - getAllBooks
    
    func deleteBook(bookToDelete : Book){
        
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty) {
            print(#function, "Logged in user information not available. Can't add the book")
        } else {
            
            self.db.collection(COLLECTION_LIBRARY)
                .document(loggedInUserEmail)
                .collection(COLLECTION_BOOKS)
                .document(bookToDelete.id!)
                .delete{ error in
                    if let err = error {
                        print(#function, "Unable to delete book : \(err)")
                    } else {
                        print(#function, "successfully deleted : \(bookToDelete.title)")
                    }
                }
            
        }
        
        
    }
    
    func updateBook(bookToUpdate : Book){
        
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty) {
            print(#function, "Logged in user information not available. Can't add the book")
        } else {
            
            self.db.collection(COLLECTION_LIBRARY)
                .document(loggedInUserEmail)
                .collection(COLLECTION_BOOKS)
                .document(bookToUpdate.id!)
                .updateData([ FIELD_TITLE : bookToUpdate.title,
                             FIELD_AUTHOR : bookToUpdate.author,
                          FIELD_ISFICTION : bookToUpdate.isFiction ]) { error in
                    
                    if let err = error {
                        print(#function, "Unable to update document : \(err)")
                    } else {
                        print(#function, "Successfully updated : \(bookToUpdate.title)")
                    }
                }
           } // if-else
    } // func
        
        
        
}
