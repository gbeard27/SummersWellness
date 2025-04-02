//
//  ContentView.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/16/25.

import SwiftUI

struct CustomButtonStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.custom("AvenirNext-Regular", size: 20))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: 200)
            .background(Color(red: 67/255, green: 103/255, blue: 70/255))
            .cornerRadius(10)
            .shadow(radius:5)
    }
}


struct ContentView: View {
    var body: some View {
        NavigationStack {
            LoginView()
        }
    }
}
