
import SwiftUI
import SwiftData

struct Dashboard: View {
    @StateObject var guestPreferencesViewModel = GuestPreferencesViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query var bookings: [Booking]
    var viewModel: DashboardViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {

                // LOGO + HEADER
                VStack(spacing: 8) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)

                    Capsule()
                        .frame(width: 60, height: 4)
                        .foregroundColor(Color(red: 228/255, green: 173/255, blue: 102/255))
                }
                .padding(.top)

                // INFO DISPLAY
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .center, spacing: 6) {
                        Text("Personal Info")
                            .font(.custom("AvenirNext-Regular", size: 26))
                            .foregroundColor(Color(red: 62/255, green: 62/255, blue: 36/255))

                        VStack(alignment: .center, spacing: 4) {
                            Text("Welcome, \(viewModel.user.name)!")
                            Text("Email: \(viewModel.user.email)")
                        }
                        .font(.custom("AvenirNext-Regular", size: 18))
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                    .cornerRadius(16)
                    .shadow(radius: 2)

                    VStack(alignment: .center, spacing: 6) {
                        Text("Booked Activities")
                            .font(.custom("AvenirNext-Regular", size: 26))
                            .foregroundColor(Color(red: 62/255, green: 62/255, blue: 36/255))

                        Text(bookedActivitiesText())
                            .font(.custom("AvenirNext-Regular", size: 18))
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                    .cornerRadius(16)
                    .shadow(radius: 2)
                }
                .padding(.horizontal, 24)

                // BUTTON GRID
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    DashboardWideButton(title: "Book Activities")
                    DashboardWideButton(title: "Farm Fresh Food")
                    DashboardWideButton(title: "Activity Recommendations")
                    DashboardWideButton(title: "SmartWatch Integration")
                    DashboardWideButton(title: "Health Tracker")
                    DashboardWideButton(title: "Explore the Farm")

                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
    }

    func fetchBookings() {
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

//Dashboard Button View
struct DashboardWideButton: View {
    var title: String
    var color: Color = Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.85)
    var guestModel: GuestPreferencesViewModel? = nil

    var body: some View {
        NavigationLink(destination: destinationForTitle(title)) {
            HStack {
                Text(title)
                    .font(.custom("AvenirNext-Regular", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 130)
            .background(color)
            .cornerRadius(16)
            .shadow(radius: 2)
        }
    }

    @ViewBuilder
    func destinationForTitle(_ title: String) -> some View {
        switch title {
        case "Book Activities": BookActivities()
        case "Explore the Farm": ExploreTheFarm()
        case "Activity Recommendations": UserPreferencesView()
        case "SmartWatch Integration": Watch()
        case "Health Tracker": CalorieTrackerForm()
        case "Personalized Recommendations": Recommendations()
        case "Farm Fresh Food": FoodDash()
            // corporate
        case "Book Large Group Activities": LargeBookActivities()
        case "Book Rental Space": CorporateBookingView()
            //wedding
        case "View Resort Spaces and Themes": ResortPhotoGallery()
        case "Book a Tour": BookTour()
        case "Meal Recommender":
                    if let model = guestModel {
                        MealView(viewModel: model)
                    } else {
                        Text("No data")
                    }
        case "Dietary Restrictions Form":
            if let model = guestModel {
                FoodFormView(viewModel: model)
            } else {
                Text("No data")
            }
        case "Book a Meal": BookMealView()
        case "Benefits of Fresh Grown Food": FoodPreferencesView()
        default: Text("Unknown destination for: \(title)")
        }
    }
}
