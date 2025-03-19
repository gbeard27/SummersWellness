//
//  ContentView.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/16/25.

import SwiftUI

struct CustomButtonStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: 200)
            .background(Color.green)
            .cornerRadius(10)
            .shadow(radius:5)
    }
}

struct ContentView: View {
    @State private var selectedDashboard: String?
    @State private var loggedInUser: User
    
    var body: some View {
        
        
        
        VStack {
            Text("Welcome, \(loggedInUser.name)!")
                .font(.title)
                .padding()
            
            Text("Choose Your Dashboard")
                .font(.title2)
                .padding()
            
            Button("Personal Dashboard") {
                selectedDashboard = "Personal"
            }
            .modifier(CustomButtonStyle())
            .padding()
            
            Button("Corporate Dashboard") {
                selectedDashboard = "Corporate"
            }
            .modifier(CustomButtonStyle())
            .padding()
            
            Button("Wedding Dashboard") {
                selectedDashboard = "Wedding"
            }
            .modifier(CustomButtonStyle())
            .padding()
        }}}
