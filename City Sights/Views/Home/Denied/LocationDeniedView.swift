//
//  LocationDeniedView.swift
//  City Sights
//
//  Created by tom montgomery on 3/22/23.
//

import SwiftUI

struct LocationDeniedView: View {
    
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            Text("Whoops!")
                .font(.title)
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in settings")
            Spacer()
            Button {
                // Action - Open settings - allows deep link to Settings app
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    // TODO: doesn't fully deep link on simulator - maybe it would on actual iphone?
                    if UIApplication.shared.canOpenURL(url) {
                        // if canOpen returns true, then open it
                        // just pass options of an empty dictionary [:]
                        // no need for completion handler
                        //UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        // ALTERNATE
                        UIApplication.shared.open(url)
                    }
                }
                
              
                
            } label: {
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text("Open Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                        .padding()
                    //make same as backgroundColor b/c the button is white
                    
                }
            }
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
