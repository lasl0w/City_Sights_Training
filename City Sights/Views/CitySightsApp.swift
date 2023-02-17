//
//  City_SightsApp.swift
//  City Sights
//
//  Created by tom montgomery on 2/7/23.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
