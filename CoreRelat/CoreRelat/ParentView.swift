//
//  ParentView.swift
//  CoreRelat
//
//  Created by Pedram Faghihi on 2024-03-11.
//

import SwiftUI
import CoreData

struct ParentView: View {
    @EnvironmentObject var dataController : DataController
    
    let schools : FetchRequest<School>
    
    @State var showingAddSchool : Bool = false
    
    init(){
        schools = FetchRequest<School>(entity: School.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \School.date, ascending: false)])
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    List {
                        ForEach(schools.wrappedValue) { school in
                            NavigationLink (destination: DetailView(school: school )){
                                VStack(alignment: .leading) {
                                    Text(school.name ?? "").font(.headline)
                                    Spacer()
                                    Text("\(school.address ?? "")").font(.subheadline)
                                }.padding()
                            }
                        }
                        .onDelete(perform: deleteSchool)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
            }
            .navigationTitle("School")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Add Sample Data") {
                        dataController.createSampleData()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showingAddSchool = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSchool) {
                AddNewSchoolView()
            }
        }
    }
    
    func deleteSchool( at offsets : IndexSet) {
        for offset in offsets {
            let school = schools.wrappedValue[offset]
                dataController.delete(school)
            }
            dataController.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    static var previews: some View {
        
         ParentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
