//
//  DashboardViewModel.swift
//  SummersWellnessFarm
//
//  Created by Kapp, Tara  (Student) on 3/16/25.
//


// Fetches data and handles logic

import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var user: User
    @Published var dashboardType: DashboardType

    init(user: User, dashboardType: DashboardType) {
        self.user = user
        self.dashboardType = dashboardType
    }
}

enum DashboardType: String, Codable, Identifiable {
    case personal
    case corporate
    case wedding
    
    var id: String { self.rawValue }
}



    // Add methods to manage data for the specific dashboard type if needed
