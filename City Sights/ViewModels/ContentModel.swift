//
//  ContentModel.swift
//  City Sights
//
//  Created by tom montgomery on 2/7/23.
//

import Foundation
import CoreLocation

// TODO: does protocol order matter?
class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    // once we define it here (as an OO protocol), even empty, we can add it to the main entry as a .environmentObject()
    
    // PUBLISHED PROPERTIES - now that we've parsed some data, let's publish some of these objects
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    
    // the basics if you are using CoreLocation
    var locationManager = CLLocationManager()
    
    // Instead of using the init() in NSObject, i want to write my own
    override init () {
        // since we are overriding we need to call the init() method of the parent NSObject before executing our own init
        super.init()
        
        
        // Set the content model as the delagate of the location manager
        // MUST conform to the CL protocol... which only accepts NSObjects, so have to conform to that too
        locationManager.delegate = self
        
        
        // Request permission from the user - only use "WhenInUse" unless "Always" is truly needed
        locationManager.requestWhenInUseAuthorization()
        // must also set a specific KEY in the INFO.PLIST
        // in plist :: Privacy - Location When in Use Description
        // set our custom text to show in the entitlement modal
        
        
        // Start geolocating the user, after we get perms
        //locationManager.startUpdatingLocation()
    }
    
    // MARK: Location Manager Delegate Methods
    
    // we have to implement these in order to conform to the protocol
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // gets called as a result of .requestWhenInUseAuthorization()
        
        print(locationManager.authorizationStatus.rawValue)
        // enum values have dots!
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            // we have permission
            // start geolocating the user
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
                // we don't have permission
                
        }
    }
    
    // tells the delegate that new locations are available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // keeps firing when there are location changes
        // if we only need it once, stop requesting the location
        
        // play - what's in locations?  it might be empty
        print(locations.first ?? "no location")
        // it used to keep updating every few seconds.  now it appears to wait for significant location changes?  yay - less chatty.
        let userLocation = locations.first
        
        if userLocation != nil {
            // We have a good location
            // Stop requesting the location
            locationManager.stopUpdatingLocation()
            
            // if we have the coords of the user, send to the yelp API
            getBusiness(category: Constants.sightsKey, location: userLocation!)
            getBusiness(category: Constants.restaurantsKey, location: userLocation!)
        }
       
    }
    
    // YELP Business Search API
    // base APIURL = https://api.yelp.com/v3/businesses/search
    // param example = APIURL?latitude=83.291&longitude=83.291
    // set category as well
    
    // MARK: - Yelp API methods
    
    func getBusiness(category:String, location: CLLocation) {
        
        // Create URL String
        // METHOD 1:  ol' fashioned string interpolation
        //let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        //let url = URL(string: urlString)
        // METHOD 2:  urlComponents array w/optional chaining
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        // some components could be nil
        let url = urlComponents?.url
        
        if let url = url {
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                // check that there isnt an error
                if error == nil {
                    //print(response)
                    do {
                        // Parse the data
                        let decoder = JSONDecoder()
                        // What (structure/class) are we decoding into?  BusinessSearch!
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        //print(result)
                        
                        // THIS is a BACKGROUND THREAD!!!  Don't assign things to a @Published property in the background thread
                        // Instead, put it in the DispatchQueue
                        DispatchQueue.main.async {
                            // Assign results to appropriate property
//                            if category == Constants.sightsKey {
//                                self.sights = result.businesses
//                            }
//                            else if category == Constants.restaurantsKey {
//                                self.restaurants = result.businesses
//                            }
                            // If we have lots of categories, SWITCH scales better
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                            default:
                                break
                            }
                        }
                       
                    }
                    catch {
                        print(error)
                    }

                }
            }
            // Start the datatask
            dataTask.resume()
        }

    }
    
}
