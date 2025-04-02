//
//  LargeGroupActivities.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/27/25.
//

import SwiftUI
import SwiftData

struct LargeBookActivities: View {
    @State private var activitiesByCapacity: [(String, [Activity])] = []
    @State private var selectedActivity: Activity?
    @Environment(\.modelContext) private var modelContext
    @Query var bookings: [Booking]

    var body: some View {
        NavigationStack {
            VStack {
                Text("Book Large Group Activities")
                    .font(.custom("AvenirNext-Regular", size: 15))
                    .fontWeight(.bold)
                    .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(activitiesByCapacity, id: \.0) { (capacityGroup, activities) in
                            VStack(alignment: .leading) {
                                Text(capacityGroup)
                                    .font(.custom("AvenirNext-Regular", size: 22))
                                    .fontWeight(.bold)
                                    .padding(.leading, 16)
                                    .padding(.bottom, 8)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(activities) { activity in
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
                    .padding(.top)
                }
            }
            .onAppear {
                let allActivities = loadAllActivities()

                var grouped = Dictionary(grouping: allActivities, by: { activity in
                    switch activity.capacity {
                    case 1..<10: return "Small Groups (1-9)"
                    case 10..<20: return "Medium Groups (10-19)"
                    case 20..<50: return "Large Groups (20-49)"
                    case 50..<100: return "Very Large Groups (50-99)"
                    default: return "Massive Groups (100+)"
                    }
                })

                activitiesByCapacity = grouped
                    .map { (key, value) in (key, value.sorted { $0.capacity < $1.capacity }) } // Sort activities inside groups
                    .sorted { groupOrder($0.0) < groupOrder($1.0) } // Sort the group order
            }
            .sheet(item: $selectedActivity) { activity in
                BookingView(activity: activity)
                    .modelContainer(for: [Booking.self, Activity.self])
            }
        }
    }
    
    func groupOrder(_ group: String) -> Int {
        switch group {
        case "Small Groups (1-9)": return 1
        case "Medium Groups (10-19)": return 2
        case "Large Groups (20-49)": return 3
        case "Very Large Groups (50-99)": return 4
        case "Massive Groups (100+)": return 5
        default: return 99
        }
    }
}

#Preview {
    NavigationStack {
        LargeBookActivities()
            .modelContainer(for: [Booking.self, Activity.self])
    }
}

