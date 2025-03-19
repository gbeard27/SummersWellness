//
//  User.swift
//  SummersWellnessFarm
//
//  Created by Kapp, Tara  (Student) on 3/16/25.
//

import SwiftData
import Foundation

@Model
class User {
    var id: UUID
    var name: String
    var email: String
    var password: String

    // ✅ Required initializer for @Model
    init(name: String, email: String, password: String) {
        self.id = UUID() // Auto-generate unique ID
        self.name = name
        self.email = email
        self.password = password
    }
}

