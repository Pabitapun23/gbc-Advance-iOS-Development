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
            
        }
        
        .navigationTitle(Text("Detail View"))
    }//body
    
    private func updateBook(){
        
        dismiss()
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedBookIndex: 0)
    }
}
