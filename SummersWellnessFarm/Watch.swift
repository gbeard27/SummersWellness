//
//  Watch.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/21/25.
//

import SwiftUI

struct WatchIntegrationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Watch Integration")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 30)
            
            Button(action: {
                print("Fitbit integration tapped")
            }) {
                Text("Fitbit")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                print("Garmin integration tapped")
            }) {
                Text("Garmin")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            Button(action: {
                print("Apple Watch integration tapped")
            }) {
                Text("Apple Watch")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
    }
}
#Preview {
    WatchIntegrationView()
}
