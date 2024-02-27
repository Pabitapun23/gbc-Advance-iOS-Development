//
//  MainView.swift
//  FirestoreDemo
//
//  Created by J Patel on 2024-02-21.
//

import SwiftUI


struct MainView: View {
    private let fireDBHelper = FireDBHelper.getInstance()
    var fireAuthHelper = FireAuthHelper()
    
    @State private var root : RootView = .Login
    
    var body: some View {
        
        NavigationStack{
            
            switch(root){
                case .Login:
                    SignInView(rootScreen: self.$root).environmentObject(fireAuthHelper)
                case .SignUp:
                    SignUpView(rootScreen: self.$root).environmentObject(fireAuthHelper)
                case .Home:
                    HomeView(rootScreen: self.$root)
                        .environmentObject(self.fireDBHelper)
                        .environmentObject(self.fireAuthHelper)
            }
        }//NavigationView
        
    }//body
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
