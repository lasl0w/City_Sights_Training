//
//  BusinessMap.swift
//  City Sights
//
//  Created by tom montgomery on 3/7/23.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    // 3 funcs to conform - make, update, dismantle
    
    // need a reference to the model for our computed 'location' property
    @EnvironmentObject var model: ContentModel
    // use MKPointAnnotation instead of MKAnnotation b/c we are working with string data at a point (coordinate)
    var locations: [MKPointAnnotation] {
        // computed property
        
        var annotations = [MKPointAnnotation]()
        
        // Create a set of annotations from our list of businesses
        for business in model.restaurants + model.sights {
            // shortcut instead of doing 2 FOR loops
            // If the business has a lat/long, create a location for it.  OPTIONAL BINDING
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                // If either one is nil, it will skip this block
                
                var a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
    }
    
    // return MKMapView instead of some UIView
    func makeUIView(context: Context) -> MKMapView {
        // make a new mapview
        
        let mapView = MKMapView()
        
        // set some properties on it
        
        // show user's location
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // TODO: set the region if necessary - it's not in this case
        // may not be needed since we are going to drop all the pins then tell the map to zoom out to see them all
        
        return mapView
    }
    // also change to MKMapView as the type, instead of UIView when working with maps
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on the business
        //uiView.addAnnotations(self.locations)
        // Instead of add(), use show().  It sets the region so we get a zoom level containing all the pins
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(<#T##annotations: [MKAnnotation]##[MKAnnotation]#>)
    }
    
}
