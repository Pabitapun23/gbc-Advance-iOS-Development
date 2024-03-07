//
//  DetailView.swift
//  CoreDataDemo
//
//  Created by J Patel on 2024-02-21.
//

import SwiftUI

struct DetailView: View {
    
    let selectedBookIndex : Int
    @State private var title : String = "test title"
    @State private var author : String = ""
    @State private var fiction : Bool = true
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coreDBHelper: CoreDBHelper
    
    var body: some View {
        VStack{
            Form{
                TextField("Enter title", text: self.$title)
                TextField("Enter author", text: self.$author)
                
                Toggle(isOn: self.$fiction, label: {
                    Text("Fiction")
                })
                
            }//Form ends
            
            Button(action: {
                self.updateBook()
            }){
                Text("Update Book")
            } // Button
            
            
            Spacer()
        }//VStack ends
        
        .navigationTitle(Text("Detail View"))
        .frame(maxWidth: .infinity)
        .onAppear(){
            self.title = self.coreDBHelper.bookList[selectedBookIndex].title
            self.author = self.coreDBHelper.bookList[selectedBookIndex].author
            self.fiction = self.coreDBHelper.bookList[selectedBookIndex].isFiction
        } // .onAppear
        
    }//body
    
    private func updateBook(){
        self.coreDBHelper.bookList[selectedBookIndex].title = self.title
        self.coreDBHelper.bookList[selectedBookIndex].author = self.author
        self.coreDBHelper.bookList[selectedBookIndex].isFiction = self.fiction
        
        self.coreDBHelper.updateBook()
        dismiss()
    } // func
    
}
