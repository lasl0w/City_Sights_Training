//
//  HomeView.swift
//  City Sights
//
//  Created by tom montgomery on 2/24/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    // Default view is list view.  This State var allows us to toggle list vs map
    @State var isMapShowing = false
    // selectedBusiness is STATE here, but BINDING in the BizMap - 2-way, allowing read+write back and forth
    // When we assign a selectedBusiness (after we detect a user tap), we trigger the sheet
    @State var selectedBusiness: Business?
    
    var body: some View {
        
        // Will show if there are sites
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            // NavView is here.  NavLinks are in the BusinessRow
            NavigationView {
                // Determine if we should show list or map
                if !isMapShowing {
                    // Show list
                    VStack {
                        HStack {
                            Image(systemName: "location")
                            Text(model.placemark?.locality ?? "Unknown Location")
                            // Spacer will push out button to the right
                            Spacer()
                            Button("Switch to map view") {
                                self.isMapShowing = true
                            }
                        }
                        // Figma has a divider between the header and the list
                        Divider()
                        // .top so the Yelp image doesn't display in the center of the view (vertically)
                        ZStack(alignment: .top) {
                            BusinessList()
                            
                            // HStack with spacer so we right align the image
                            HStack {
                                Spacer()
                                YelpAttribution(link: "https://yelp.com")
                            }
                            .padding(.trailing, -20)
                            // apply negative padding to park it on the edge of the phone

                        }
                    }
                    .padding([.horizontal, .top])
                        .navigationBarHidden(true)
                    // NavBarHidden is not added to the NavView, but on the child view
                }
                else {
                    // .top mainly so the location+button overlay can be vertically at the top
                    ZStack(alignment: .top) {
                        // show the map
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                        // we want it to be full screen
                            .sheet(item: $selectedBusiness) { business in
                                
                                // Create a business detail view instance
                                // Pass in the selected business
                                BusinessDetail(business: business)
                                
                            }
                        // SHEET - usually use a bool, but this time use the item/content method
                        // SHEET - content = businessDetail view, item = selected business (ontap)
                        // SHEET (item) Needs to be a BINDING, so it should be a STATE var
                        ZStack {
                            // this sits atop the map
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(height: 48)
                            HStack {
                                Image(systemName: "location")
                                Text(model.placemark?.locality ?? "Unknown Location")
                                Spacer()
                                Button("Switch to List View") {
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                            // for inside rectangle edges

                        }
                        .padding()
                        // for device edges
                    }
                }
            }
        }
        else {
            // still waiting for data, so show spinner
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
