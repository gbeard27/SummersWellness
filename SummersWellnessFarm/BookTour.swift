//
//  BookTour.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 3/11/25.
//

import SwiftUI

struct Tour: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

struct BookTour: View {
    @State private var selectedDate = Date()
    @State private var selectedTour: Tour?
    @State private var showingConfirmation = false
    
    let availableTours: [Tour] = [
        Tour(name: "Wedding Walk Through", description: "Walk through the resort to look at different Wedding locations."),
        Tour(name: "Garden Tour", description: "A peaceful walk through our scenic vineyards and gardens."),
        Tour(name: "Nature Hike", description: "A guided hike through our nature trails, perfect for wildlife and photography lovers.")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Title
            Text("Book a Tour")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            // Date Picker
            DatePicker("Select Tour Date", selection: $selectedDate, displayedComponents: .date)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
            
            // List of Available Tours
            Text("Available Tours")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            List(availableTours) { tour in
                TourRow(tour: tour, isSelected: selectedTour?.id == tour.id)
                    .onTapGesture {
                        selectedTour = tour
                    }
            }
            .listStyle(PlainListStyle())
            
            // Booking Button
            Button(action: {
                if selectedTour != nil {
                    showingConfirmation = true
                }
            }) {
                Text("Book Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTour == nil ? Color.gray : Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .disabled(selectedTour == nil)
            .padding()
        }
        .padding()
        .alert(isPresented: $showingConfirmation) {
            Alert(
                title: Text("Confirm Booking"),
                message: Text("Are you sure you want to book \(selectedTour?.name ?? "") on \(formattedDate(selectedDate))?"),
                primaryButton: .default(Text("Confirm")) {
                    print("Booking confirmed for \(selectedTour?.name ?? "") on \(formattedDate(selectedDate))")
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Tour List Row Component
struct TourRow: View {
    let tour: Tour
    let isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(tour.name)
                    .font(.headline)
                Text(tour.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(isSelected ? Color.green.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
}

struct BookTour_Previews: PreviewProvider {
    static var previews: some View {
        BookTour()
    }
}
