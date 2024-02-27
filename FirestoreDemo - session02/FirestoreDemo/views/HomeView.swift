//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by J Patel on 2024-02-21.
//

import SwiftUI

struct HomeView: View {
    @State private var showNewBookView : Bool = false
    @State private var selection : Int? = nil
    @State private var selectedIndex : Int = -1
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @Binding var rootScreen : RootView
    
    var body: some View {

        ZStack(alignment: .bottom){
            List{
                ForEach(self.fireDBHelper.bookList.enumerated().map({$0}), id: \.element.self){index, currentBook in

                    VStack(alignment: .leading){
                        Text("\(currentBook.title)")
                            .fontWeight(.bold)

                        Text("by \(currentBook.author)")
                            .italic()
                    }//VStack
                    .onTapGesture {
                        self.selectedIndex = index
                        print(#function, "selected book index : \(self.selectedIndex) \(self.fireDBHelper.bookList[selectedIndex].title)")

                        self.selection = 1
                    }

                }//ForEach
                .onDelete(perform: {indexSet in
                    for index in indexSet{
                        print(#function, "Book to delete : \(self.fireDBHelper.bookList[index].title)")

                        self.fireDBHelper.bookList.remove(at: index)
                    }
                })
                
            }//List ends
            
            
            Button(action: {
                self.showNewBookView = true
            } ){
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.green)
            }//Button ends
            .sheet(isPresented: self.$showNewBookView){
                NewBookView().environmentObject(self.fireDBHelper)
            }
        }
    
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action : {
                    self.fireAuthHelper.signOut()
                    self.rootScreen = .Login
                }){
                    Text("Sign Out")
                }
            }
        }
        .navigationTitle("MyLibrary")
        
        .onAppear(){
            //get all books from DB
        }
    }
}
