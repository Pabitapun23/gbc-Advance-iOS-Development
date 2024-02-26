//
//  Book.swift
//  CoreDataDemo
//
//  Created by J Patel on 2024-02-21.
//

import Foundation
import FirebaseFirestoreSwift // allows us mapping between firestore and swift object

struct Book : Codable, Hashable{
    @DocumentID var id : String? = UUID().uuidString
    var title : String = ""
    var author : String = ""
    var isFiction : Bool = false
    var dateAdded : Date = Date()
    
    init() {
        
    }
    
    init(title: String, author : String, fiction : Bool){
        self.title = title
        self.author = author
        self.isFiction = fiction
        self.dateAdded = Date()
    }
    
    init(title : String, author : String, fiction : Bool, date : Date){
        self.title = title
        self.author = author
        self.isFiction = fiction
        self.dateAdded = date
    }
    
}
