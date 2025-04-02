//
//  Recommendations.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/26/25.
//

import SwiftUI

struct Recommendations: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                Text("Personalized Recommendations")
                    .font(.custom("AvenirNext-Bold", size: 34))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding(.top, 20)

                // Sustainability Section
                SectionView(title: "Health", content: """
                Our Farm to Table Experience
                """)
                SectionView(title: "Outdoor", content: """
                Our outdoor Nature Walk/Hikes
                """)
                SectionView(title: "Excercise", content: """
                Yoga
                Pilates
                """)


                Spacer()
            }
            .padding(.horizontal, 20)
            .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))

        }
    }
}


#Preview {
    NavigationStack {
        Recommendations()
    }
}


