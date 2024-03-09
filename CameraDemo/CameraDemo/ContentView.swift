//
//  ContentView.swift
//  CameraDemo
//
//  Created by J Patel on 2024-03-06.
//

import SwiftUI
import PhotosUI

/*
 Permissions
 
 Privacy - Camera usage description
 CameraDemo app needs to access Camera to click pictures
 
 Privacy - Photo Library Usage Description
 CameraDemo app needs to access Photo Library
 
 Privacy - Photo Library Additions Usage Description
 CameraDemo app needs to access Photo Library to save pictures
 
 */

struct ContentView: View {
    @State private var profileImage : UIImage?
    @State private var showSheet: Bool = false
    @State private var permissionGranted: Bool = false
    @State private var showPicker : Bool = false
    @State private var isUsingCamera : Bool = false
    
    var body: some View {
        VStack{
            Image(uiImage: profileImage ?? UIImage(systemName: "snow")!)
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
            
            Button(action:{
                if (self.permissionGranted) {
                    self.showSheet = true
                } else {
                    self.requestPermission()
                    // alternatively, show the message for user that permissions aren't granted
                }
                
            }){
                Text("Upload Picture")
                    .padding()
            }
            .actionSheet(isPresented: self.$showSheet){
                ActionSheet(title: Text("Select Photo"),
                            message: Text("Choose profile picture to upload"),
                            buttons: [
                .default(Text("Choose photo from library")){
                    //show library picture picker
                    
                    // check if the source is available
                    guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                        print(#function, "The photo library isn't available")
                        return
                    }
                    
                    self.isUsingCamera = false
                    self.showPicker = true
                    
                },
                .default(Text("Take a new pic from Camera")){
                    //open camera
                    guard UIImagePickerController.isSourceTypeAvailable(.camera)
                    else {
                        print(#function, "Camera isn't available")
                        return
                    }
                    
                    self.isUsingCamera = true
                    self.showPicker = true
                    
                },
              .cancel()
             ])
            }
        }//VStack
        .fullScreenCover(isPresented: self.$showPicker){
            if (isUsingCamera){
                //open camera Picker
                CameraPicker(selectedImage: self.$profileImage)
            }else{
                //open library picker
                LibraryPicker(selectedImage: self.$profileImage)
            }
        }
        .onAppear{
            self.checkPermission()
        }
    }//body
    
    private func checkPermission(){
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            self.permissionGranted = true
        case .notDetermined, .denied:
            self.permissionGranted = false
            self.requestPermission()
        case .limited, .restricted: break
            // inform the user about possibly granting full access
        @unknown default:
            return
        }
    }
    
    private func requestPermission(){
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.permissionGranted = true
            case .notDetermined, .denied:
                self.permissionGranted = false
            case .limited, .restricted: break
                // inform the user about possibly granting full access
            @unknown default:
                return
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
