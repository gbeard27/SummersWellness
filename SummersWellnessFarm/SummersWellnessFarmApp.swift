//
//  SummersWellnessFarmApp.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/16/25.
//  Test
// test 1

import SwiftUI

@main
struct SummersWellnessFarmApp: App {
    @StateObject private var userSession = UserSession()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self, Booking.self, Activity.self])
                .environmentObject(userSession)

            
        }
    }
}
