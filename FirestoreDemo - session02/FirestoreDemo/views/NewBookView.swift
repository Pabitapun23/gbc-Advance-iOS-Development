//
//  NewBookView.swift
//  CoreDataDemo
//
//  Created by J Patel on 2024-02-21.
//

import SwiftUI

struct NewBookView: View {
    @State private var title : String = ""
    @State private var author : String = ""
    @State private var fiction : Bool = true
    @State private var showErrorAlert : Bool = false
    @State private var alertMessage : String = ""
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        VStack{
            Form{
                    TextField("Enter title", text: self.$title)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.words)
                
                TextField("Enter author", text: self.$author)
                
                Toggle(isOn: self.$fiction, label: {
                    Text("Fiction")
                })
                
            }//Form ends
            
            Button(action: {
                self.addNewBook()
            }){
                Text("Insert Book")
            }
            .alert(isPresented: self.$showErrorAlert){
                Alert(
                    title: Text("Error"),
                    message: Text(self.alertMessage),
                    dismissButton: .default(Text("Try Again"))
                    )//Alert ends
            }// .alert ends
            
            Spacer()
        }//VStack ends
        .onDisappear(){
            
        }
        
    }//body ends
    
    
    private func addNewBook(){
        if (self.title.isEmpty || self.author.isEmpty){
            //show error
            self.alertMessage = "Title and/or Author cannot be empty"
            self.showErrorAlert = true
        }else{
            //add the book details to database
            //call insertBook() from controller
            
            let newBook = Book(title: self.title, author: self.author, fiction: self.fiction)
            self.fireDBHelper.insertBook(newBook: newBook)
        }
        
        //dismiss currently presented view
        dismiss()
    }
    
    
}//NewBookView ends

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}
