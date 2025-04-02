//
//  CorporateDashboard.swift
//  SummersWellnessFarm
//
//  Created by Tia Li on 3/11/25.
//

/*import SwiftUI
import SwiftData

struct CorporateDashboard: View {
    let viewModel: DashboardViewModel
    
    var body: some View {
        VStack{
            Text("Corporate Dashboard")
                .font(.custom("AvenirNext-Regular", size: 34))
                .padding()

            SectionView(title: "Group Info", content: """
            - Primary Contact Name: Jane Doe
            - Email: example@summerswellness.com
            - Group Size: 50 Guests
            """)
                
                
                NavigationLink(destination: LargeBookActivities()){
                    Text("Book Activities")
                        .modifier(CustomButtonStyle())
                }
                
                
                NavigationLink(destination: ExploreTheFarm()){
                    Text("Explore The Farm")
                        .modifier(CustomButtonStyle())
                }
                
                NavigationLink(destination: CorporateBookingView()){
                    Text("Book Rental Space")
                        .modifier(CustomButtonStyle())
                }
                
                .navigationTitle("Dashboard")
            }
        }
    }
}*/

//LAYOUT 1
import SwiftUI
import SwiftData

struct CorporateDashboard: View {
    let viewModel: DashboardViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {

                // LOGO + HEADER
                VStack(spacing: 8) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)

                    Text("Corporate Dashboard")
                        .font(.custom("AvenirNext-Bold", size: 34))
                        .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                        .padding(.top, 20)

                    Capsule()
                        .frame(width: 60, height: 4)
                        .foregroundColor(Color(red: 228/255, green: 173/255, blue: 102/255))
                }
                .padding(.top)

                // INFO TILE
                VStack(alignment: .center, spacing: 6) {
                    Text("Group Info")
                        .font(.custom("AvenirNext-Regular", size: 26))
                        .foregroundColor(Color(red: 62/255, green: 62/255, blue: 36/255))

                    Text("""
                    - Primary Contact Name: Jane Doe
                    - Email: example@summerswellness.com
                    - Group Size: 50 Guests
                    """)
                    .font(.custom("AvenirNext-Regular", size: 18))
                    .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: 400, alignment: .center)
                .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                .cornerRadius(16)
                .shadow(radius: 2)
                .padding(.horizontal, 24)

                // BUTTON GRID
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    DashboardWideButton(title: "Book Large Group Activities")
                    DashboardWideButton(title: "Explore the Farm")
                    DashboardWideButton(title: "Book Rental Space")
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
    }
}

