//
//  ContentView.swift
//  Bored
//
//  Created by J Patel on 2024-03-07.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activityHelper = ActivityHelper()
    @State private var activityTitle : String = "Loading..."
    
    var body: some View {
        NavigationView{
            VStack {
                
                Text("\(self.activityTitle)")
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                
                Button(action: {
                    self.getAnotherActivity()
                }){
                    Text("Try another")
                }
                .buttonStyle(.borderedProminent)
                
            }
            .padding()
            .onAppear{
                self.getAnotherActivity()
            }
            
            .navigationTitle("Bored")
        }
    }//body
    
    private func getAnotherActivity(){
        self.activityHelper.fetchActivity(withCompletion: {activity in
            
            self.activityTitle = activity?.activityName ?? "Nothing to do"
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
