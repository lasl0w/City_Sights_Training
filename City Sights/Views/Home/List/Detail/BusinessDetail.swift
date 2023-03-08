//
//  BusinessDetail.swift
//  City Sights
//
//  Created by tom montgomery on 2/28/23.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    var body: some View {
        
        
        // Note - any container element can not have more than 10 elements
        // although you can get around it using the GROUP container
        VStack(alignment: .leading) {
            
            // make the Open/Closed banner hug the image - spacing 0
            VStack (alignment: .leading, spacing: 0) {
                GeometryReader() { geo in
                    // convert our image data to a UIImage to prep it for Image()
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    // Problem - the image will expand to take all the space it needs, especially since it's first
                    // Solution - use a geometry reader
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped() // so it doesn't spill out of the frame
                }
                .ignoresSafeArea(.all, edges: .top)
                // design decision - cool, but it covers the back link
                
                
                // Open / Closed indicator
                ZStack (alignment: .leading){
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                    
                }
            }
            
            // use Group to get around the 10 element limit
            Group {
                
                // Business name
                Text(business.name!)
                    .font(.title)
                    .padding()
                // loop through displayAddress after nil check
                if business.location?.displayAddress! != nil {
                    ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                        Text(displayLine)
                            .padding(.horizontal)
                    }
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                
                Divider()
                
                // Phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    
                    // follow the URL scheme to trigger the phone on tap
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                    // TODO: why is the unwrap in that spot....
                    
                }
                .padding()
                
                
                Divider()
                
                // Reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    //TODO: why does this break the build
                    // MUST cast to a String if the whole thing is an INT
                    Text(String(business.reviewCount ?? 0))
                    //Text("545")
                    Spacer()
                    
                    // follow the URL scheme to trigger the phone on tap
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                    // TODO: why is the unwrap in that spot....
                    
                }
                .padding()
                
                
                Divider()
                
                // Website
                HStack {
                    Text("Website:")
                        .bold()
                    
                    // MUST cast to a String if the whole thing is an INT
                    Text(business.url ?? "")
                        .lineLimit(1)
                    // lineLimit so we don't have 4 lines of a really long URL
                    Spacer()
                    
                    // follow the URL scheme to trigger the phone on tap
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                    // TODO: why is the unwrap in that spot....
                    
                }
                .padding()
                
                Divider()
            }
            
            // Get directions button
            Button {
                // TODO: show directions
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
        
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding()
        }
        
    }
}

//struct BusinessDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessDetail()
//    }
//}
