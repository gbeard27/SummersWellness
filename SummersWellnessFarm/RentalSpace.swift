//
//  RentalSpace.swift
//  SummersWellnessFarm
//
//  Created by Tia Li on 3/9/25.
//
import SwiftUI

// Renamed to CorporateSpace
struct CorporateSpace: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let pricePerDay: Double
    let imageName: String
}

struct CorporateBookingView: View {
    @State private var selectedDate = Date()
    @State private var selectedSpace: CorporateSpace?
    @State private var showingConfirmation = false
    
    let corporateSpaces: [CorporateSpace] = [
        CorporateSpace(name: "Executive Barn Suite", description: "A stylish barn-inspired suite with a private meeting area, high-speed Wi-Fi, and farm views.", pricePerDay: 300, imageName: "executive-barn-suite"),
        CorporateSpace(name: "Conference Lodge", description: "A fully equipped conference space with AV technology, seating for 20, and a cozy fireplace.", pricePerDay: 250, imageName: "conference-lodge"),
        CorporateSpace(name: "Farmhouse Boardroom", description: "A charming farmhouse-style boardroom with a large table, whiteboard, and scenic views.", pricePerDay: 200, imageName: "farmhouse")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Title
            Text("Book a Space")
                .font(.custom("AvenirNext-Bold", size: 34))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .padding(.horizontal)
            
            // Date Picker
            DatePicker("Select Booking Date", selection: $selectedDate, displayedComponents: .date)
                .padding()
                .font(.custom("AvenirNext-Regular", size: 22))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                .cornerRadius(10)
                .shadow(radius: 5)
            
            // List of Corporate Spaces
            Text("Available Spaces")
                .font(.custom("AvenirNext-Regular", size: 22))
                .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                .padding(.horizontal)
            
            List(corporateSpaces) { space in
                CorporateSpaceRow(space: space, isSelected: selectedSpace?.id == space.id)
                    .onTapGesture {
                        selectedSpace = space
                    }
            }
            .listStyle(PlainListStyle())
            
            // Booking Button
            Button(action: {
                if selectedSpace != nil {
                    showingConfirmation = true
                }
            }) {
                Text("Book Now")
                    .font(.custom("AvenirNext-Regular", size: 17))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedSpace == nil ? Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08) : Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .disabled(selectedSpace == nil)
            .padding()
        }
        .padding()
        .alert(isPresented: $showingConfirmation) {
            Alert(
                title: Text("Confirm Booking"),
                message: Text("Are you sure you want to book \(selectedSpace?.name ?? "") on \(formattedDate(selectedDate))?"),
                primaryButton: .default(Text("Confirm")) {
                    // Handle booking confirmation (e.g., send to backend)
                    print("Booking confirmed for \(selectedSpace?.name ?? "") on \(formattedDate(selectedDate))")
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

struct CorporateSpaceRow: View {
    let space: CorporateSpace
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(space.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.green : Color.clear, lineWidth: 2)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(space.name)
                    .font(.custom("AvenirNext-Regular", size: 22))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                Text(space.description)
                    .font(.custom("AvenirNext-Regular", size: 17))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                Text("$\(String(format: "%.2f", space.pricePerDay)) / day")
                    .font(.custom("AvenirNext-Regular", size: 17))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
            }
            
            Spacer()
        }
        .padding()
        .background(isSelected ? Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.1) : Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
        .cornerRadius(10)
        .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
    }
}

struct CorporateBookingView_Previews: PreviewProvider {
    static var previews: some View {
        CorporateBookingView()
    }
}

