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
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @Binding var rootScreen : RootView
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                List{
                    ForEach(self.fireDBHelper.bookList.enumerated().map({$0}), id: \.element.self){index, currentBook in

                        NavigationLink(destination: DetailView(selectedBookIndex: index).environmentObject(self.fireDBHelper)) {
                            VStack(alignment: .leading){
                                Text("\(currentBook.title)")
                                    .fontWeight(.bold)

                                Text("by \(currentBook.author)")
                                    .italic()
                            }//VStack
                        } // NavigationLink
                    }//ForEach
                    .onDelete(perform: {indexSet in
                        for index in indexSet{
                            print(#function, "Book to delete : \(self.fireDBHelper.bookList[index].title)")

                            self.fireDBHelper.deleteBook(bookToDelete: self.fireDBHelper.bookList[index])
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
            } // ZStack
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    self.fireAuthHelper.signOut()
                    self.rootScreen = .Login
                }) {
                    Text("Sign Out")
                }
            }
            
        }
        .navigationTitle("My Library")

    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
