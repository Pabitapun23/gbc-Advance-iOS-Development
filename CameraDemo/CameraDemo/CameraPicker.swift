//
//  CameraPicker.swift
//  CameraDemo
//
//  Created by J Patel on 2024-03-06.
//

import Foundation
import SwiftUI
import PhotosUI

struct CameraPicker : UIViewControllerRepresentable {
    
    @Binding var selectedImage : UIImage?
    
    // represent what's the default ui we want to have or initial ui.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        // configure CameraPicker
        var imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
            
    } // func
    
    func updateUIViewController(_ uiViewController: CameraPicker.UIViewControllerType, context: Context) {
        // nothing to update on UI
    } // func
    
    func makeCoordinator() -> CameraPicker.Coordinator {
       return Coordinator(parent: self)
    } // func
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent : CameraPicker
        
        init(parent: CameraPicker) {
            self.parent = parent
        } // init
        
        // user opens the camera and successfully clicks the picture
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // use the clicked picture
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                self.parent.selectedImage = image
                picker.dismiss(animated: true)
                
                // save image to PhotoLibrary
                PHPhotoLibrary.shared().performChanges({
                    
                    let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    
                    PHAssetCollectionChangeRequest(for: PHAssetCollection())?.addAssets([creationRequest.placeholderForCreatedAsset!] as NSArray)
                })
                
            } else {
                print(#function, "Image not available from originalImage property")
                return
            }// if-let
            
        } // func-imagePickerController()
        
        // user opens the camera but didn't any picture
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        } // func-imagePickerControllerDidCancel()
        
    } // class - Coordinator
    
    
}
