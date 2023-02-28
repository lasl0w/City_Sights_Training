//
//  BusinessList.swift
//  City Sights
//
//  Created by tom montgomery on 2/24/23.
//

import SwiftUI

// List called from the HomeView
struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // get rid of scroll bar indicator
        ScrollView (showsIndicators: false){
            // Use Lazy b/c there could be many rows
            // Scrollview + VStack + Section combo - use pinnedViews property 
            
            LazyVStack (alignment: .leading, pinnedViews: .sectionHeaders) {
                // if it did not conform to Identifiable Property, then we would need to have an ID in the ForEach.  id: \.self  .
                // Instead, make the Model conform.
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
 
                BusinessSection(title: "Sights", businesses: model.sights)
                // MORE ORGANIZED, MORE REUSABLE - moving BusinessSection to subviews

                
                
//                Section(header: BusinessSectionHeader(title: "Sights")) {
//                    ForEach(model.sights) { business in
//                        Text(business.name ?? "Unknown Biz")
//                        Divider()
//                    }
//                }
               
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
