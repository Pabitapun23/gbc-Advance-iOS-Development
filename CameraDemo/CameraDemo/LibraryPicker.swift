//
//  LibraryPicker.swift
//  CameraDemo
//
//  Created by J Patel on 2024-03-06.
//

import Foundation
import SwiftUI
import PhotosUI

struct LibraryPicker : UIViewControllerRepresentable{
    
    @Binding var selectedImage : UIImage?
    
    // represent what's the default ui we want to have or initial ui.
    func makeUIViewController(context: UIViewControllerRepresentableContext<LibraryPicker>) -> some UIViewController {
        
        // configure LibraryPicker
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        var imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = context.coordinator
        return imagePicker
        
            
    } // func
    
    func updateUIViewController(_ uiViewController: LibraryPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<LibraryPicker>) {
        // nothing to update on UI
    } // func
    
    func makeCoordinator() -> LibraryPicker.Coordinator {
        return Coordinator(parent: self)
    } // func
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent : LibraryPicker
        
        init(parent: LibraryPicker) {
            self.parent = parent
        } // init
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            if (results.count <= 0) {
                return
            } // if
            
            if let selectedImage = results.first {
                
                if selectedImage.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    
                    // convert the selected asset to UIImage type
                    selectedImage.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        
                        guard error == nil else {
                            print(#function, "Cannot convert selected asset to UIImage")
                            return
                        } // guard-else
                        
                        if let img = image {
                            
                            // get meta information about image if needed
                            let identifiers = results.compactMap(\.assetIdentifier)
                            let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
                            let imageMetaData = fetchResults.firstObject
                            print(#function, "duration: \(imageMetaData?.duration)")
                            print(#function, "location: \(imageMetaData?.location)")
                            print(#function, "pixelWidth: \(imageMetaData?.pixelWidth)")
                            print(#function, "pixelHeight: \(imageMetaData?.pixelHeight)")
                            print(#function, "isFavorite: \(imageMetaData?.isFavorite)")
                            print(#function, "creationDate: \(imageMetaData?.creationDate)")
                            
                            self.parent.selectedImage = img as? UIImage
                            
                        } // if-let
                        
                    }
                    
                } else {
                    print(#function, "Cannot get UIImage object from selected image")
                    return
                }
                
            } // if-let
            
        } // func
        
    } // class - Coordinator
}
