//
//  MapView.swift
//  Pabita_Final
//
//  Created by Pabita Pun on 2024-03-12.
//

import SwiftUI
import MapKit

struct MapView : UIViewRepresentable{
    
    typealias UIViewType = MKMapView
    
    // CLLocation representing the location of the selected restaurant
    private var location: CLLocation?
    
    // Address of the selected restaurant
    private var restaurantAddress: String?
    
    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    
    init(location : CLLocation?, restaurantAddress: String?){
        self.location = location
        self.restaurantAddress = restaurantAddress
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isUserInteractionEnabled = true
        map.showsUserLocation = true
        return map
    }
        
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations) // Remove previous annotations
        
        // Add annotation for the selected restaurant location
        if let location = location {
            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.coordinate = location.coordinate
            mapAnnotation.title = restaurantAddress ?? "Unknown Address"
            uiView.addAnnotation(mapAnnotation)
            
            // Set region to show the selected restaurant's location
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            uiView.setRegion(region, animated: true)
        }
    }
    
}

