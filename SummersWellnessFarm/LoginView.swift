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
                
                // LOGO + HEADER
                VStack(spacing: 8) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                .padding(.top)
                
                
                if isAuthenticated, let user = loggedInUser {
                    Text("Welcome, \(user.name)!")
                        .font(.custom("AvenirNext-Regular", size: 28))
                        .padding()

                    Text("Select Your Dashboard:")
                        .font(.custom("AvenirNext-Regular", size: 17))
                        .padding(.top)

                    // Select Dashboard Type
                    // Direct Navigation
                    ForEach(DashboardType.allCases, id: \.self) { type in
                        NavigationLink(value: type) {
                            Text("\(type.rawValue) Dashboard")
                        }
                            .modifier(CustomButtonStyle())
                            .padding()
                    }

                    
                } else {
                    // Login Form
                    Text("Login to Your Account")
                        .font(.custom("AvenirNext-Regular", size: 34))
                        .padding()

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .font(.custom("AvenirNext-Regular", size: 22))
                        .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("AvenirNext-Regular", size: 22))
                        .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                        .padding()

                    // Login Button
                    Button("Login") {
                        login()
                    }
                    .font(.custom("AvenirNext-Regular", size: 22))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()

                    Text(loginError)
                        .font(.custom("AvenirNext-Regular", size: 22))
                        .foregroundColor(.red)
                    
                    // Sign Up Button
                    Button("Don't have an account? Sign Up") {
                        isShowingSignup = true
                    }
                    .font(.custom("AvenirNext-Regular", size: 22))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()
                }
            }
            .padding()
            .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
            
            .navigationDestination(for: DashboardType.self) { type in
                if let user = loggedInUser {
                    switch type {
                    case .personal:
                        Dashboard(viewModel: DashboardViewModel(user: user, dashboardType: type))
                    case .corporate:
                        CorporateDashboard(viewModel: DashboardViewModel(user: user, dashboardType: type))
                    case .wedding:
                        WeddingDashboard(viewModel: DashboardViewModel(user: user, dashboardType: type))
                    }
                } else {
                    // Optional: fallback if user somehow becomes nil
                    Text("Error: No user found")
                }
            }


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

