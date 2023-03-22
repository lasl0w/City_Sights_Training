//
//  OnboardingView.swift
//  City Sights
//
//  Created by tom montgomery on 3/19/23.
//

import SwiftUI

struct OnboardingView: View {
    // OnboardingView shows both tabs
    
    @EnvironmentObject var model: ContentModel
    // Implement with TabView to achieve the carousel effect
    @State private var tabSelection = 0
    // TODO: Can't i just put in a hex value?
    private var blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private var turquoise = Color(red: 55/255, green: 192/255, blue: 192/255)
    
    var body: some View {
        
        VStack {
            
            // Tab View - make it a binding so we set and know
            TabView(selection: $tabSelection) {
                
                // First Tab
                VStack(spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    Text("City Sights helps you find the best of the city")
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.white)
                // make text white
                .tag(0)
                // tag will map to the tabSelection
                
                
                // Second Tab
                VStack (spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discovery your city?")
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text("We'll show you the best restaurants, venues and more, based on your location")
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.white)
                .tag(1)
            }
            .padding()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // indexDisplayMode shows the paging dots
            
            // Button
            Button {
                // Detect tabSelection
                
                if tabSelection  == 0 {
                    tabSelection = 1
                }
                else {
                    // TODO: request for geolocation permission
                    model.requestGeolocationPermission()
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    // "Inline if" aka ternary operator
                    Text(tabSelection == 0 ? "Next" : "Get My Location")
                        .bold()
                        .padding()
                }
            }
            .padding()
            .accentColor(tabSelection == 0 ? blue : turquoise)
            // on tab0 make text color blue

        }
        .background(tabSelection == 0 ? blue : turquoise)
        // .ignoresSafeArea()
        // ORDER of modifiers matters!  they stack
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
