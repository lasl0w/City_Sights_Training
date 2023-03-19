//
//  DirectionsView.swift
//  City Sights
//
//  Created by tom montgomery on 3/13/23.
//

import SwiftUI

struct DirectionsView: View {
    
    // need to pass in the Biz to give directions for
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                // Business name
                BusinessTitle(business: business)
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let lon = business.coordinates?.longitude,
                   let name = business.name {
                    // example of LINK w/PLACEHOLDER URL
                    Link("Open in Maps", destination: URL(string: "http://maps.apple.com/\(lat),\(lon)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
                    // we force unwrapped.  to be extra safe, do the .addingPercentEncoding above and make sure it's not nil first

                }
                
            }
            .padding()

            // Directions to said biz
            DirectionsMap(business: business)
        }
        // get more map at the bottom
        //.ignoresSafeArea(.all, edges: .bottom)
    }
}

//struct DirectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsView()
//    }
//}
