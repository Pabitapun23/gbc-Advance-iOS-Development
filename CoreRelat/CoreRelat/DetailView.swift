//
//  DetailView.swift
//  CoreRelat
//
//  Created by Pedram Faghihi on 2024-03-11.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let school : School
    
    var teachers : [Teacher]
    
    var students : [Student]
    
    var principal : [Principal] = []
    
    @State private var showingAddPrincipal : Bool = false
    @State private var showingAddTeacher : Bool = false
    @State private var showingAddStudent : Bool = false
    
    init(school : School) {
        self.school = school
        
        self.teachers  = school.teachers?.allObjects as! [Teacher]
        self.teachers = self.teachers.sorted(by: {$0.date! < $1.date!})
        
        
        self.students = school.students?.allObjects as! [Student]
        self.students = self.students.sorted(by: {$0.date! < $1.date!})
        
        if let prin = school.principal {
            self.principal.append(prin)
        }
    }
    
    var body: some View {
        Form {
            Section (header: Text("Principal")) {
                List {
                    ForEach(principal) { princ in
                        NavigationLink  {
                            PrincipalDetailView(principal: princ)
                        } label: {
                            Label(school.principal?.name ?? "", systemImage: "star.fill")
                        }
                    }
                    .onDelete(perform: deletePrincipal)
                    Button  {
                        self.showingAddPrincipal = true
                    } label: {
                        Text("Add Principal")
                    }
                }
             }
            Section (header: Text("Teachers")) {
                List {
                    ForEach(teachers) { teacher in
                        NavigationLink {
                            TeacherDetailView(teacher: teacher)
                        } label: {
                            Label(teacher.name ?? "", systemImage: "bolt.fill")
                        }
                    }
                    .onDelete(perform: deleteTeacher)
                    Button  {
                        self.showingAddTeacher = true
                    } label: {
                        Text("Add Teacher")
                    }
                }
            }
            Section (header: Text("Students")) {
                List {
                    ForEach(students) { student in
                        NavigationLink {
                            StudentDetailView(student: student)
                        } label: {
                            Label(student.name ?? "", systemImage: "heart.fill")
                        }
                    }
                    .onDelete(perform: deleteStudent)
                    Button  {
                        self.showingAddStudent = true
                    } label: {
                        Text("Add Student")
                    }
                }
            }
        }
        .navigationTitle(Text("Details"))
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddPrincipal) {
            AddNewPrincipalView(school: self.school)
        }
        .sheet(isPresented: $showingAddTeacher) {
            AddNewTeacherView(school: self.school)
        }
        .sheet(isPresented: $showingAddStudent) {
            AddNewStudentView(school: self.school)
        }
    }
    
    //Function to remove individual items
    func deleteTeacher( at offsets : IndexSet) {
        for offset in offsets {
                let teacher = teachers[offset]
                dataController.delete(teacher)
            }
            dataController.save()
    }
    
    func deleteStudent( at offsets : IndexSet) {
        for offset in offsets {
                let student = students[offset]
                dataController.delete(student)
            }
            dataController.save()
    }
    
    func deletePrincipal( at offsets : IndexSet) {
        for offset in offsets {
                let princi = principal[offset]
                dataController.delete(princi)
            }
            dataController.save()
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        let school = School(context: dataController.container.viewContext)
        
        return DetailView(school: school)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
