//
//  StudentDetailView.swift
//  CoreRelat
//
//  Created by Pedram Faghihi on 2024-03-11.
//

import SwiftUI

struct StudentDetailView: View {
    
    let student : Student
    
    // The school, principal and teachers objects are fetched from
    // the student object itself
    var school : School? {
        student.school
    }
    var principal : Principal? {
        student.principal
    }
    var teachers : [Teacher] {
        student.teachers?.allObjects as? [Teacher] ?? []
    }
    
    var body: some View {
        Form {
            Section (header: Text("Name")){
                List {
                    Text(student.name ?? "")
                }
            }
            Section (header : Text("School")) {
                List {
                    Text (school?.name ?? "")
                }
            }
            Section (header: Text("Principal")) {
                List {
                    Text (principal?.name ?? "")
                }
            }
            Section (header : Text ("Teachers")) {
                List {
                    ForEach (teachers) { teacher in
                        Text(teacher.name ?? "")
                    }
                }
            }
        }
        .navigationTitle("Student")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StudentDetailView_Previews: PreviewProvider {
    
    static let dataController = DataController.preview
    
    static var previews: some View {
        let student = Student(context: dataController.container.viewContext)
        student.name = "Cedric Diggory"
        return StudentDetailView(student: student)
    }
}
