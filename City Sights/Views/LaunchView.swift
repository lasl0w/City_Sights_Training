//
//  ContentView.swift
//  City Sights
//
//  Created by tom montgomery on 2/7/23.
//

import SwiftUI
// Need Core Location Module for our CLAuth statuses
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of geolocating the user
        
        if model.authorizationState == .notDetermined {
            // If undetermined, show onboarding
            OnboardingView()
        }
        else if model.authorizationState == CLAuthorizationStatus.authorizedAlways || model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse {
            // If approved, show home view
            HomeView()
        }
        else {
            // If denied, show denied view
            LocationDeniedView()
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
