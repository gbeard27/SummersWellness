//
//  FoodDash.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/26/25.
//

import SwiftUI



struct FoodDash: View {
    var body: some View {
        VStack{
            Text(" Food Dashboard")
                .font(.custom("AvenirNext-Regular", size: 34))
                .padding()
            SectionView(title: "Personal Info", content: """
            - Name: Jane Doe
            - Room Number: 301
            - Email: example@summerswellness.com
            """)
            
            SectionView(title: "Booked Activities", content: """
            - Farm to Table Experience: 2/28 at 7:00pm
            - Outdoor Yoga: 2/29 at 8:00am
            - Massage: 2/29 at 11:00am
            """)
            // Activities button
            
            // Explore the farm button
            
            NavigationLink(destination: FarmToTableView()){
                Text("Farm to Table info")
                    .modifier(CustomButtonStyle())
            }
            
            NavigationLink(destination: FoodFormView(viewModel: GuestPreferencesViewModel())) {
                Text("Food Preferences")
                    .modifier(CustomButtonStyle())
            }

            
    }
        .navigationTitle("Dashboard")
    }
}

#Preview {
    FoodDash()
}

