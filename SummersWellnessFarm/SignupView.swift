//
//  SignupView 2.swift
//  SummersWellnessFarm
//
//  Created by Kapp, Tara  (Student) on 3/16/25.
//
import SwiftUI
import SwiftData

struct SignupView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    @Environment(\.dismiss) var dismiss  // Allows dismissing the view after signup

    var body: some View {
        VStack {
            TextField("Full Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("AvenirNext-Regular", size: 22))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("AvenirNext-Regular", size: 22))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                .padding()
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("AvenirNext-Regular", size: 22))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("AvenirNext-Regular", size: 22))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                .padding()

            Button(action: createAccount) {
                Text("Sign Up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.custom("AvenirNext-Regular", size: 22))
                    .background(Color(red: 67/255, green: 103/255, blue: 70/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Signup"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                if alertMessage == "Account created successfully!" {
                    dismiss()  // Go back to login screen after successful registration
                }
            })
        }
    }

    func createAccount() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        // Check if user already exists
        let descriptor = FetchDescriptor<User>(predicate: #Predicate { $0.email == email })
        do {
            let existingUsers = try modelContext.fetch(descriptor)
            if !existingUsers.isEmpty {
                alertMessage = "Email already in use."
                showAlert = true
                return
            }
        } catch {
            print("Error checking existing users: \(error.localizedDescription)")
        }

        // Create and save new user
        let newUser = User(name: name, email: email, password: password)
        modelContext.insert(newUser)

        do {
            try modelContext.save()
            alertMessage = "Account created successfully!"
            showAlert = true
        } catch {
            print("Error saving user: \(error.localizedDescription)")
            alertMessage = "Failed to create account."
            showAlert = true
        }
    }
}

