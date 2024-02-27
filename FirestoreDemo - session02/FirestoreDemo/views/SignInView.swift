//
//  SignInView.swift
//  FirestoreDemo
//
//  Created by J Patel on 2024-02-21.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @Binding var rootScreen : RootView
    
    @State private var email : String = ""
    @State private var password : String = ""
    
    private let gridItems : [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
            VStack{
                
                Form{
                    TextField("Enter Email", text: self.$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Enter Password", text: self.$password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                }//Form ends
                .disableAutocorrection(true)
                
                LazyVGrid(columns: self.gridItems){
                    Button(action: {
                        //validate the data
                        if (!self.email.isEmpty && !self.password.isEmpty){
                            
                            //validate credentials
                            self.fireAuthHelper.signIn(email: self.email, password: self.password)
                            
                            //navigate to home screen
                            self.rootScreen = .Home
                        }else{
                            //trigger alert displaying errors
                            print(#function, "email and password cannot be empty")
                        }
                    }){
                        Text("Sign In")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(Color.blue)
                    }
                    
                    Button(action: {
                        //take the user to signup screen
                        self.rootScreen = .SignUp
                    }){
                        Text("Sign Up")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(Color.blue)
                    }
                }//LazyVGrid ends

                Spacer()
            }//VStack ends
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                self.email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
                self.password = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
            }
    }//body ends
}
