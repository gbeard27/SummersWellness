//
//  FarmToTable.swift
//  SummersWellnessFarm
//
//  Created by Tia Li on 2/22/25.
// This is the farm to table page needs to be connected to button 
import SwiftUI

struct FarmToTableView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                Text("Farm to Table Experience")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Sustainability Section
                SectionView(title: "Sustainability Practices", content: """
                Our resort is committed to sustainable practices, including:
                - Composting to reduce waste
                - Using renewable energy sources
                - Conserving water through efficient irrigation systems
                """)
                
                // Cultivation Experience Section
                SectionView(title: "Cultivation Experience", content: """
                Join us on-site to experience the cultivation of fresh and seasonal ingredients. Our farm offers:
                - Hands-on farming activities
                - Insights into organic farming techniques
                """)
                
                // Cooking Classes Section
                SectionView(title: "Cooking Classes", content: """
                Enhance your culinary skills with our cooking classes:
                - Learn to prepare dishes with fresh ingredients
                - Classes available for all skill levels
                - Schedule: Mondays and Thursdays at 10 AM
                """)
                
                // Meal Reservations Section
                SectionView(title: "Meal Reservations", content: """
                Reserve your table for a farm-to-table dining experience:
                - Enjoy meals crafted from our freshest ingredients
                - Reservations available for lunch and dinner
                """)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

// Reusable Section View
struct SectionView: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(5)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct FarmToTableView_Previews: PreviewProvider {
    static var previews: some View {
        FarmToTableView()
    }
}
