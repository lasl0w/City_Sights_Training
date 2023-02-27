//
//  BusinessSection.swift
//  City Sights
//
//  Created by tom montgomery on 2/26/23.
//

import SwiftUI

// REFACTORED - for reusability, let's move the BusinessSection from BusinessList to it's own subview

struct BusinessSection: View {
    
    // What needs to be passed in? Businesses and the section title
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        // Use Section so you can apply header or footer
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                BusinessRow(business: business)
            }
        }
    }
}

//struct BusinessSection_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSection()
//    }
//}
