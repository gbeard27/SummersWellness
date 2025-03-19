//
//  LoginView.swift
//  SummersWellnessFarm
//
//  Created by Kapp, Tara  (Student) on 3/16/25.
//import SwiftUI

import SwiftUI
import SwiftData


struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var isAuthenticated = false
    @State private var loggedInUser: User?
    @State private var isShowingSignup = false
    @State private var selectedDashboard: DashboardType?
    @State private var navigateToDashboard = false

    var body: some View {
        NavigationStack {
            VStack {
                if isAuthenticated, let user = loggedInUser {
                    Text("Welcome, \(user.name)!")
                        .font(.title)
                        .padding()

                    Text("Select Your Dashboard:")
                        .font(.headline)
                        .padding(.top)

                    // Select Dashboard Type
                    VStack {
                        Button("Personal Dashboard") {
                            navigateToDashboard = true
                            selectedDashboard = .personal
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()

                        Button("Corporate Dashboard") {
                            navigateToDashboard = true
                            selectedDashboard = .corporate
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()

                        Button("Wedding Dashboard") {
                            navigateToDashboard = true
                            selectedDashboard = .wedding
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                                .navigationDestination(isPresented: $navigateToDashboard) {
                                    if let dashboardType = selectedDashboard {
                                        Dashboard(viewModel: DashboardViewModel(user: user, dashboardType: dashboardType))
                                    }
                    }
                } else {
                    // Login Form
                    Text("Login to Your Account")
                        .font(.title)
                        .padding()

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    // Login Button
                    Button("Login") {
                        login()
                    }
                    .padding()

                    Text(loginError)
                        .foregroundColor(.red)
                    
                    // Sign Up Button
                    Button("Don't have an account? Sign Up") {
                        isShowingSignup = true
                    }
                    .foregroundColor(.blue)
                    .padding()
                }
            }
            .padding()
            .navigationDestination(isPresented: $isShowingSignup) {
                SignupView()
            }
        }
    }

    // Login Function
    private func login() {
        do {
            let descriptor = FetchDescriptor<User>(predicate: #Predicate { $0.email == email && $0.password == password })
            if let user = try modelContext.fetch(descriptor).first {
                loggedInUser = user
                isAuthenticated = true
            } else {
                loginError = "Invalid email or password"
            }
        } catch {
            loginError = "Error fetching user: \(error.localizedDescription)"
        }
    }
}
