//
//  YelpAttribution.swift
//  City Sights
//
//  Created by tom montgomery on 3/22/23.
//

import SwiftUI

// Attribution needs to be applied in the BusinessList() and BusinessDetail() views
struct YelpAttribution: View {
    
    // Need to pass in the link as a string, depending on the view we are coming from
    var link: String
    
    var body: some View {
        
        Link(destination: URL(string: link)!) {
            // label
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        }
    }
}

struct YelpAttribution_Previews: PreviewProvider {
    static var previews: some View {
        YelpAttribution(link: "https://yelp.co")
    }
}
