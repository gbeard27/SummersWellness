//
//  Watch.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/21/25.
//

import SwiftUI
// Navigation Link
struct Watch: View{
    var body: some View{
        VStack{
            WatchIntegrationView()
        }

        }
    }



struct WatchIntegrationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Watch Integration")
                .font(.custom("AvenirNext-Bold", size: 34))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .padding(.top, 30)
            
            Button(action: {
                print("Fitbit integration tapped")
            }) {
                Text("Fitbit")
                    .modifier(CustomButtonStyle())
            }
            
            Button(action: {
                print("Garmin integration tapped")
            }) {
                Text("Garmin")
                    .modifier(CustomButtonStyle())
            }
            
            Button(action: {
                print("Apple Watch integration tapped")
            }) {
                Text("Apple Watch")
                    .modifier(CustomButtonStyle())
            }
            
            Spacer()
        }
    }
}
#Preview {
    WatchIntegrationView()
}

