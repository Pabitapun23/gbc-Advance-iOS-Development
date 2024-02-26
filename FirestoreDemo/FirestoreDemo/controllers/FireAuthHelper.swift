//
//  FireAuthHelper.swift
//  FirestoreDemo
//
//  Created by J Patel on 2024-02-21.
//

import Foundation
import FirebaseAuth

class FireAuthHelper: ObservableObject{
    
    @Published var user : User? {
        
        // manually keep track if any object change
        didSet {
            objectWillChange.send()
        }
    }
    
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            guard let self = self else {
                // no change in the auth state
                return
            }
            
            // user's auth state has changed
            self.user = user
        }
    }
    
    func signUp(email : String, password : String){
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            
            guard let result = authResult else {
                print(#function, "ERROR while creating account : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult {
            case .none:
                print(#function, "Unable to create the account")
            case .some:
                print(#function, "Successfully created the account")
                self.user = authResult?.user
                
                // create a document to User_Library collection with user's email
                // have all the fields empty or with default value
                // allow the user to input/update their details in the Profile Screen
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
        }
        
    }
    
    func signIn(email : String, password : String){
        Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
            
            guard let result = authResult else {
                print(#function, "ERROR while creating account : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult {
            case .none:
                print(#function, "Unable to sign in")
            case .some:
                print(#function, "Login Successful")
                self.user = authResult?.user
                
                print(#function, "Logged in user : \(self.user?.displayName ?? "NA" )")
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        } catch let err as NSError {
            print(#function, "Unable to sign out the user: \(err)")
        }
    }
    
}
