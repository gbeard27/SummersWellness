import SwiftUI
import SwiftData

@Model
class Activity: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var image: String
    var groupTitle: String
    var capacity: Int
    var times: [String]
    var daysAvailable: [String]
    var activityDescription: String

    init(id: UUID = UUID(), name: String, image: String, groupTitle: String, capacity: Int, times: [String], daysAvailable: [String], activityDescription: String) {
        self.id = id
        self.name = name
        self.image = image
        self.groupTitle = groupTitle
        self.capacity = capacity
        self.times = times
        self.daysAvailable = daysAvailable
        self.activityDescription = activityDescription
    }
}


@Model
class Booking: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var activityID: UUID
    var activityName: String
    var selectedDay: String
    var selectedTime: String
    var bookedSlots: Int

    init(activityID: UUID, activityName: String, selectedDay: String, selectedTime: String, bookedSlots: Int) {
        self.activityID = activityID
        self.activityName = activityName
        self.selectedDay = selectedDay
        self.selectedTime = selectedTime
        self.bookedSlots = bookedSlots
        
        @Relationship var user: User
    }
}

struct BookActivities: View {
    @State private var activities: [Activity] = []
    @State private var selectedActivity: Activity?
    @Environment(\ .modelContext) private var modelContext
    @Query var bookings: [Booking]
    
    var groupedActivities: [String: [Activity]] {
        Dictionary(grouping: activities, by: { $0.groupTitle })
    }
    
    var sortedCategories: [String] {
        groupedActivities.keys.sorted {
            if $0 == "Corporate & Events" { return false } // Keep "Corporate & Events" at the bottom
            if $1 == "Corporate & Events" { return true }
            return $0 < $1 // Otherwise, sort alphabetically
        }
    }
    
    var body: some View {
        VStack {
            Text("Book Activities")
                .font(.custom("AvenirNext-Bold", size: 34))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(sortedCategories, id: \ .self) { group in
                        VStack(alignment: .leading) {
                            Text(group)
                                .font(.custom("AvenirNext-Bold", size: 25))
                                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                                .padding(.leading, 16)
                                .padding(.bottom, 8)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(groupedActivities[group] ?? []) { activity in
                                        Button(action: {
                                            selectedActivity = activity
                                        }) {
                                            ActivityRow(activity: activity, bookings: bookings)

                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
            .onAppear {
                activities = loadAllActivities()
            }
            .sheet(item: $selectedActivity) { activity in
                BookingView(activity: activity)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { 
                    if !bookings.isEmpty {
                        Button(action: clearBookings) {
                            Label("Clear All", systemImage: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
    }
    
    
    func clearBookings() {
        for booking in bookings {
            modelContext.delete(booking)
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to clear bookings: \(error)")
        }
    }
}
struct ActivityRow: View {
    let activity: Activity
    let bookings: [Booking]
    
    var body: some View {
        VStack {
            Image(systemName: activity.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding()
                .foregroundColor(.white)
            
            Text(activity.name)
                .font(.custom("AvenirNext-Bold", size: 17))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
            
        }
        .frame(width: 150, height: 175)
        .padding()
        .background(Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.85))
        .cornerRadius(10)
    }
}

struct BookingView: View {
    let activity: Activity
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTime: String = "Select a Time"
    @State private var selectedDay: String = "Select a Day"
    @State private var bookedSlots: Int = 1
    @Query private var existingBookings: [Booking]
    
    @State private var showBookingAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Book \(activity.name)")
                .font(.custom("AvenirNext-Bold", size: 34))
                .fontWeight(.bold)
                .padding()
            
            Text(activity.activityDescription)
                .font(.custom("AvenirNext-Regular", size: 22))
                .padding()

            Picker("Select Day", selection: $selectedDay) {
                Text("Select a Day").tag("Select a Day")
                ForEach(activity.daysAvailable, id: \.self) { day in
                    Text(day).tag(day)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Picker("Select Time", selection: $selectedTime) {
                Text("Select a Time").tag("Select a Time")
                ForEach(activity.times, id: \.self) { time in
                    Text(time).tag(time)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Stepper("Number of People: \(bookedSlots)", value: $bookedSlots, in: 1...activity.capacity)
                .font(.custom("AvenirNext-Regular", size: 17))
                .padding()
            
            let totalBookedSlots = calculateTotalBookedSlots()
            let availableSlots = activity.capacity - totalBookedSlots

            Text("Available Slots: \(availableSlots)")
                .font(.custom("AvenirNext-Regular", size: 17))
                .foregroundColor(availableSlots > 0 ? .green : .red)
                .font(.headline)

            Button("Confirm Booking") {
                if bookedSlots <= availableSlots {
                    let newBooking = Booking(
                        activityID: activity.id,
                        activityName: activity.name,
                        selectedDay: selectedDay,
                        selectedTime: selectedTime,
                        bookedSlots: bookedSlots
                    )
                    
                    modelContext.insert(newBooking)
                    do {
                        try modelContext.save()
                        // Set alert state to true after booking saved.
                        showBookingAlert = true
                    } catch {
                        print("Failed to save booking: \(error)")
                    }
                }
            }
            .padding()
            .background(availableSlots >= bookedSlots ? Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.85) : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(selectedTime == "Select a Time" || selectedDay == "Select a Day" || bookedSlots > availableSlots)
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showBookingAlert) {
            Alert(
                title: Text("Booking Confirmed"),
                message: Text("You have successfully booked \(activity.name) on \(selectedDay) at \(selectedTime)."),
                dismissButton: .default(Text("OK"), action: {
                    // Dismiss the view once the user taps OK.
                    dismiss()
                })
            )
        }
    }
    
    func calculateTotalBookedSlots() -> Int {
        return existingBookings
            .filter { $0.activityID == activity.id && $0.selectedDay == selectedDay && $0.selectedTime == selectedTime }
            .reduce(0) { $0 + $1.bookedSlots }
    }
}



#Preview {
    NavigationStack {
        BookActivities()
            .modelContainer(for: [Booking.self, Activity.self])

    }
}
