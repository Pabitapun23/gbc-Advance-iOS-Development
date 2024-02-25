//
//  FireDBHelper.swift
//  Pabita_A1
//
//  Created by Pabita Pun on 2024-02-23.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject {
    
    @Published var favCountryList = [Country]()
    
    private let db : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_COUNTRIES : String = "Countries"
    private let FIELD_COUNTRY_NAME : String = "common"
    private let FIELD_CAPITAL : String = "capital"
    private let FIELD_REGION : String = "region"
    private let FIELD_FLAG : String = "flag"
    private let FIELD_POPULATION : String = "population"
    
    init(db: Firestore) {
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper {
        if (shared == nil) {
            shared = FireDBHelper(db: Firestore.firestore())
        }
        return shared!
    }
    
    func addCountryToFavList(newCountry : Country){
        do {
            try self.db
                .collection(COLLECTION_COUNTRIES)
                .addDocument(from: newCountry)
        } catch let err as NSError {
            print(#function, "Unable to add document to firestore : \(err)")
        } // do-catch
        
    } // func - addCountryToFavList
    
    func getAllFavCountries(){
//        favCountryList = [Country]()
        self.db.collection(COLLECTION_COUNTRIES)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print(#function, "Unable to retrieve data from firestore : \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.favCountryList = documents.compactMap { document -> Country? in
                    do {
                        var country: Country = try document.data(as: Country.self)
                        country.id = document.documentID
                        return country
                    } catch let error {
                        print("Error decoding document: \(error)")
                        return nil
                    }
                }
            } // addSnapshotListener

    } // func - getAllFavCountries
    
    
    func deleteCountryFromFavList(countryToDelete : Country){
        
        self.db.collection(COLLECTION_COUNTRIES)
            .document(countryToDelete.id!)
            .delete{ error in
                if let err = error {
                    print(#function, "Unable to delete country : \(err)")
                } else {
                    print(#function, "successfully deleted : \(countryToDelete.name.common)")
                }
            }
 
    } // func - deleteCountryFromFavList

    
}
