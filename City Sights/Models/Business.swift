//
//  Business.swift
//  City Sights
//
//  Created by tom montgomery on 2/17/23.
//

import Foundation

// Use the JSON response in Proxyman (or a sample response in the API doc) to model the response for decoding
// Decodable b/c we need to decode the JSON response from the Yelp API
class Business: Decodable, Identifiable, ObservableObject {
    // Identifiable so we can ForEach through our list without doing 'id: \.self'
    // Switch to a CLASS to (1) let our function set the imageData and (2) to make it an ObservableObject to have published properties
    
    // use a byte buffer
    @Published var imageData: Data?
    
    
    // make everything optional as a safeguard - no results, etc
    // especially useful when the API doc doesn't specify which are guaranteed and not
    var id: String?
    var alias: String?
    var name: String?
    // using underscores temporarily for exact matching to API properties
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    // TODO: figure out why "Business does not conform to protocol Decodable when using CodingKeys
    // use CodingKeys to perform mapping
    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
        // still have to include all the other vars.  but no need to map.
        // indicating we still want that data



    }
    // When should we call this function?  could do it in BusinessRow, but then it would call it many times
    // instead, call it in the content model, when we are parsing the json
    func getImageData() {
        
        // check that the iimage url isn't nil
        guard imageUrl != nil else {
            // if it IS nil, abort
            return
        }
        
        // Download the data for the image
        
        if let url = URL(string: imageUrl!){
            // using optional binding
            // get a session
            let session = URLSession.shared
            
            // use one with a completion handler, so we can do something with the response
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    
                    // It's a published property so we need to make sure it happens in the main thread
                    DispatchQueue.main.async {
                        // Set the image data
                        // self is immutable in a struct.  time to change it to a CLASS
                        self.imageData = data
                    }
                }
            }
            dataTask.resume()
        }
    }
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?
    
    // when using CodingKeys, change your default var defs to what you want them to be (not the original 3rd party name)
    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        
        case address1
        case address2
        case address3
        case city
        case country
        case state
    }
}

struct Category: Decodable {
    
    var alias: String?
    var title: String?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
