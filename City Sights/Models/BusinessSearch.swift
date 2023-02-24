//
//  BusinessSearch.swift
//  City Sights
//
//  Created by tom montgomery on 2/21/23.
//

import Foundation

struct BusinessSearch: Decodable {
    
    // these are not optional - we are counting on the fact that each will have these properties
    var businesses = [Business]()
    var total = 0
    var region = Region()  // create an instance of the region
    
}

struct Region: Decodable {
    var center = Coordinate()
}
