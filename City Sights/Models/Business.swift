//
//  Business.swift
//  City Sights
//
//  Created by tom montgomery on 2/17/23.
//

import Foundation

// Use the JSON response in Proxyman (or a sample response in the API doc) to model the response for decoding
// Decodable b/c we need to decode the JSON response from the Yelp API
struct Business: Decodable {
    
    // make everything optional as a safeguard - no results, etc
    // especially useful when the API doc doesn't specify which are guaranteed and not
    var id: String?
    var alias: String?
    var name: String?
    var image_url: String?
    var is_closed: Bool?
    var url: String?
    var review_count: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zip_code: String?
    var country: String?
    var state: String?
    var display_address: [String]?
    var phone: String?
    var display_phone: String?
    var distance: Double?
}

struct Category: Decodable {
    
    var alias: String?
    var title: String?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
