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
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
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
            }
            
            
            Spacer()
        }//VStack ends
        .onAppear(){
            self.title = self.fireDBHelper.bookList[selectedBookIndex].title
            self.author = self.fireDBHelper.bookList[selectedBookIndex].author
            self.fiction = self.fireDBHelper.bookList[selectedBookIndex].isFiction
        }
        
        .navigationTitle(Text("Detail View"))
    }//body
    
    private func updateBook(){
        
        // update existing object in local array
        self.fireDBHelper.bookList[selectedBookIndex].title = self.title
        self.fireDBHelper.bookList[selectedBookIndex].author = self.author
        self.fireDBHelper.bookList[selectedBookIndex].isFiction = self.fiction
        
        self.fireDBHelper.updateBook(bookToUpdate: self.fireDBHelper.bookList[selectedBookIndex])
        
        dismiss()
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedBookIndex: 0)
    }
}
