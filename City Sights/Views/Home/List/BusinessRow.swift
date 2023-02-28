//
//  BusinessRow.swift
//  City Sights
//
//  Created by tom montgomery on 2/26/23.
//

import SwiftUI

struct BusinessRow: View {
    
    // gotta have the business
    // make an ObservedObject b/c we are going to be waiting on that image data to be populated
    @ObservedObject var business: Business
    
    var body: some View {
        
        // the parent VStack is basically all the content & the divider
        VStack (alignment: .leading) {
            
            // the HStack is the meat of the content here.  i.e. - the row date
            // Although there is some vert stacked content within...
            // dream in VStacks, HStacks and ZStacks.....
            HStack {
                // Image - we start with an imageURL so we need to use UIImage
                // publish imageData
                let uiImage = UIImage(data: business.imageData ?? Data())
                // create a swiftUI image from a UIKit image.  coalesce to an empty UIImage()
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                // ensure .resizable is near the top, b/c it must work off the raw image
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                // Name and distance
                VStack (alignment: .leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.1f", (business.distance ?? 0)/1000 ) + " miles away")
                        .font(.caption)
                }
                
                // Spacer to push stars to the right
                Spacer()
                
                // Star rating and number of reviews
                VStack (alignment: .leading) {
                    Image("regular_\(business.rating ?? 0)")
                    //Text("\(business.review_count ?? 0) Reviews")
                    //    .font(.caption)
                }
            }
            // Divider between each biz row
            Divider()
        }
    }
}

//struct BusinessRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessRow()
//    }
//}
