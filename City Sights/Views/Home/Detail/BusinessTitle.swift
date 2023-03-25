//
//  BusinessTitle.swift
//  City Sights
//
//  Created by tom montgomery on 3/13/23.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            // Instead of doing .padding() on each element here, we are going to leave it to the calling view
            
            // Business name
            Text(business.name!)
                .font(.title2)
                .bold()
            // loop through displayAddress after nil check
            if business.location?.displayAddress! != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            
            // Rating
            Image("regular_\(business.rating ?? 0)")
        }
        
    }
}

//struct BusinessTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessTitle()
//    }
//}
