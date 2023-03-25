//
//  BusinessSectionHeader.swift
//  City Sights
//
//  Created by tom montgomery on 2/25/23.
//

import SwiftUI

struct BusinessSectionHeader: View {
    
    var title: String
    
    var body: some View {
        
        ZStack (alignment: .leading){
            // Top is the bottom (lowest in the stack)
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 36)
            // 36 high to merge/center well with YelpAttribution image
            Text(title)
                .font(.headline)
            
            
        }
    }
}

//struct BusinessSectionHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSectionHeader()
//    }
//}
