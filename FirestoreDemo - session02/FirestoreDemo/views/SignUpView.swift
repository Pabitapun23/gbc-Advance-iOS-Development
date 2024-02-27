//
//  SignUpView.swift
//  FirestoreDemo
//
//  Created by J Patel on 2024-02-21.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @Binding var rootScreen : RootView
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    var body: some View {
        
        VStack{
            
            Form{
                
                TextField("Enter Email", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password Again", text: self.$confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }//Form ends
            .disableAutocorrection(true)
            
            Section{
                Button(action: {
                    //Task : validate the data
                    //such as all the inputs are not empty
                    //and check for password rule
                    //and display alert accordingly
                    
                    //if all the data is validated, create account on FirebaseAuth
                    self.fireAuthHelper.signUp(email: self.email, password: self.password)
                    
                    //move to home screen
                    self.rootScreen = .Home
                }){
                    Text("Create Account")
                }//Button ends
                .disabled( self.password != self.confirmPassword && self.email.isEmpty && self.password.isEmpty && self.confirmPassword.isEmpty)
                
            }//Section ends
            
        }//VStack ends
        .navigationTitle("Registration")
        .navigationBarTitleDisplayMode(.inline)
        
    }//body ends
}

