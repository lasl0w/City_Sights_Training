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
                            Text("San Francisco")
                            // Spacer will push out button to the right
                            Spacer()
                            Text("Switch to map view")
                        }
                        // Figma has a divider between the header and the list
                        Divider()
                        BusinessList()
                    }.padding([.horizontal, .top])
                        .navigationBarHidden(true)
                    // NavBarHidden is not added to the NavView, but on the child view
                }
                else {
                    // show the map
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
