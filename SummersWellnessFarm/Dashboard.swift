import SwiftUI
import SwiftData

struct Dashboard: View {
    @Environment(\.modelContext) private var modelContext
    @Query var bookings: [Booking]
    
    var body: some View {
        VStack{
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
            
            SectionView(title: "Personal Info", content: """
            - Name: Jane Doe
            - Room Number: 301
            - Email: example@summerswellness.com
            """)
            
            SectionView(title: "Booked Activities", content: bookedActivitiesText())
            
            NavigationLink(destination: BookActivities()){
                Text("Book Activities")
                    .modifier(CustomButtonStyle())
            }
            
            // Explore the farm button
            NavigationLink(destination: ExploreTheFarm()){
                Text("Explore The Farm")
                    .modifier(CustomButtonStyle())
            }
            
            // Quiz button
            NavigationLink(destination: ActivityRecs()){
                Text("Find Activity Recommendations")
                    .modifier(CustomButtonStyle())
            }
            
            // Watch integration button
            NavigationLink(destination: Watch()){
                Text("SmartWatch Integration")
                    .modifier(CustomButtonStyle())
            }
            
            NavigationLink(destination: FoodDash()){
                Text("Food Dashboard")
                    .modifier(CustomButtonStyle())
            }
            NavigationLink(destination: Recommendations()){
                Text("Personalized Recommendations")
                    .modifier(CustomButtonStyle())
            }
            
        }
        .navigationTitle("Dashboard")
    }
    
    
    func fetchBookings() {
        // Reload bookings from the model context
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    func bookedActivitiesText() -> String {
        if bookings.isEmpty {
            return "You have no booked activities."
        }
        
        let sortedBookings = bookings.sorted { $0.selectedTime < $1.selectedTime }
        
        return sortedBookings.map { booking in
            "- \(booking.activityName) on \(booking.selectedDay) at \(booking.selectedTime) for \(booking.bookedSlots) people"
        }.joined(separator: "\n")
    }
}
    
#Preview {
    Dashboard()
        .modelContainer(for: Booking.self)

}

