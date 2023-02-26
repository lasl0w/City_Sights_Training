//
//  Business.swift
//  City Sights
//
//  Created by tom montgomery on 2/17/23.
//

import Foundation

// Use the JSON response in Proxyman (or a sample response in the API doc) to model the response for decoding
// Decodable b/c we need to decode the JSON response from the Yelp API
struct Business: Decodable, Identifiable {
    // Identifiable so we can ForEach through our list without doing 'id: \.self'
    
    // make everything optional as a safeguard - no results, etc
    // especially useful when the API doc doesn't specify which are guaranteed and not
    var id: String?
    var alias: String?
    var name: String?
    // using underscores temporarily for exact matching to API properties
    // TODO alias names to our naming convention.  mapping.  DONE
    var image_url: String?
    var is_closed: Bool?
    var url: String?
    var review_count: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var display_phone: String?
    var distance: Double?
    
    // TODO: figure out why "Business does not conform to protocol Decodable
    // use CodingKeys to perform mapping
//    enum CodingKeys: String, CodingKey {
//        case imageURL = "image_url"
//        case isClosed = "is_closed"
//        case reviewCount = "review_count"
//        case displayPhone = "display_phone"
//        
//        // still have to include all the other vars.  but no need to map.  lame.
//        // indicating we still want that data
//        case id
//        case alias
//        case name
//        case url
//        case categories
//        case rating
//        case coordinates
//        case transactions
//        case price
//        case location
//        case phone
//        case distance
//    }
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
