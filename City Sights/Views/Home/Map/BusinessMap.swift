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
    // Binds to the same var in the BusinessMap - MUST pass it in
    @Binding var selectedBusiness: Business?
    
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
        // the delegate receives all the events.  The partner in crime to the MKMapView
        // we can assign any object to the delegate.  Delegate answers - "hey - we just had a tap on this annotation.  what should we do?"
        // the DELEGATE & PROTOCOL pattern - common in UIKit.  conforms to MKMapViewDelegate.  (i.e. - user tap event, user scroll event)
        
        //  'context' lets the system handle it.  If there is already a coordinator.  If none exists ,they will create a Coordinator() instance
        // 'context' has a 'coordinator' property.  don't need to create multiple coordinators.
        mapView.delegate = context.coordinator
        // the mapView AUTOMATICALLY calls specific methods based on user events (tapped, viewFor annotations)
        
        
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
        
        uiView.removeAnnotations(uiView.annotations)
    }
    

    func makeCoordinator() -> Coordinator {
        // automatically gets called when you need an instance of the Coordinator class
        print("makeCoordinator")
        return Coordinator(map: self)
        // since it's defined in the BusinessMap struct, we can just pass in self.  self refers to the whole BusinessMap (especially our binding and the EO)
    }
    
    // MARK: - Coordinator class - gets defined INSIDE the UIViewRepresentable class
    // must be a subclass of NSObject b/c MKMapViewDelegate requires it
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: BusinessMap
        
        // create a custom init so we can pass in the parent (Business Map)
        init(map: BusinessMap) {
            // the coordinator needs access to the business up in the BusinessMap
            self.parent = map
            print("Coordinator Init")
        }
        
        // return an annotation view for a specific point annotation
        // The "viewFor annotation method" of the coordinator
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Create an annotation view (CARD SHOWN ONTAP) - runs for EVERY single point (i.e. 12x in this case)
            // EVERY time we move the map around, UNTIL we implement the reuseIdentifier capabilities
    
            // get the user, blue dot back!  it has a special type - MKUserLocation
            // 'IS' is used to compare types
            if annotation is MKUserLocation {
                // skips messing with the blue dot
                return nil
            }
            
            // Check if theres a reusable annotation view first - helps performance
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            if annotationView == nil {
                // sometimes annotations get scrolled offscreen, reuse - allows you to find an annotation and reuse it.  memory savings.
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                // Set a few properties - Callout gives you the bubble
                annotationView!.canShowCallout = true
                // show a button so we can route the user to view the business details
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            } else {
                // we got a reusable one - help offscreen to back onscreen performance
                annotationView!.annotation = annotation
            }
            // Return it
            return annotationView
        }
        
        // look for 'callout' or 'tapped' to find this one
        // The "Tapped method" of the coordinator
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // User tapped on the annotation view
            print("User tapped on a map annotation")
            // all we have to reference the business is the annotation title, not the whole business
            // view.annotation?.title
            
            // Get the business object that this annotation represents
            // Loop through businesses and find the matching title
            for business in parent.model.restaurants + parent.model.sights {
                
                if business.name == view.annotation?.title {
                    //selectedBusiness = business
                    // Set the selectedBusiness property to that business object
                    parent.selectedBusiness = business
                    return
                }
            }
        }
        
    }
}
