//
//  DirectionsMap.swift
//  City Sights
//
//  Created by tom montgomery on 3/15/23.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    // Implement all the required funcs to make it conform to the protocol
    
    // Add the EO so we can get at the users location
    @EnvironmentObject var model: ContentModel
    // Pass in the business so we can have the
    var business: Business
    
    // computed property for start and end so we can reuse it and it's cleaner in the func
    var start: CLLocationCoordinate2D {
        
        // if it exists, return it, if not generate an empty one
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end: CLLocationCoordinate2D {
        
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        else {
            return CLLocationCoordinate2D()
        }
    }
    
    // instead of returning "some UIView", return an MKMapView
    func makeUIView(context: Context) -> MKMapView {
        // minimum implementation is creating the map and returning it.  2 lines of code
        // Create map
        let map = MKMapView()
        map.delegate = context.coordinator
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        // Create directions request
        let request = MKDirections.Request()
        // in order to compute directions, gotta have a source and destination
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // Create directions object
        let directions = MKDirections(request: request)
        
        // Calculate route - calls apple map servers
        directions.calculate { (response, error) in
            
            // no error and response exists,
            if error == nil && response != nil {
                for route in response!.routes {
                    // Plot the route on the map
                    // Each route point has a overlay polyline
                    map.addOverlay(route.polyline)
                    // This does not draw it yet, the delegate does that.  what color? how thick a line? etc...
                    
                    // Zoom to our current location regions
                    //map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    // use the one with EdgeInsets so we can have padding on the directions
                    map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
                }
                
                
            }
        }
        // Place annotation for the endpoint
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = business.name ?? ""
        map.addAnnotation(annotation)
        
        return map
    }
    
    // same here, passing in a mapView, not just any old UIView
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // no minimal implementation.  can be empty for initial pass
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        // no min implementation.  can be empty for initial pass
        uiView.removeAnnotations(uiView.annotations)
        
        uiView.removeOverlays(uiView.overlays)
    }
    
    // MARK: Coordinator
    
    // change the return type to Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    // "conforms to NSObject protocol and inherits from MKMapViewDelegate
    class Coordinator: NSObject, MKMapViewDelegate {
        
        // every time .addOverlay is called on a route, this event triggers
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            // the overlay is passed in as an MKPolyline
            // MKOverlay is a generic type, MKPolyline is more specific
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
        }
        
    }
    
}
