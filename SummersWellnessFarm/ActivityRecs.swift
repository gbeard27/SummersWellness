//
//  Quiz.swift
//  SummersWellnessFarm
//
//  Created by Sadie Hendrickson on 3/10/25.
//
import SwiftUI

struct ActivityRecs: View {
    @State private var selectedCategories: Set<String> = []
    @State private var recommendedActivities: [String] = []
    
    let categories = [
        "Wellness & Relaxation",
        "Outdoor & Nature",
        "Culinary & Farm-to-Table",
        "Adventure & Outdoor Sports",
        //"Corporate & Events"
    ]
    
    var body: some View {
        NavigationStack { // Replacing deprecated NavigationView
            VStack(spacing: 20) {
                Text("What kind of activities are you looking to do?")
                    .font(.custom("AvenirNext-Regular", size: 25))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()
                
                // Activity category selection
                ForEach(categories, id: \.self) { category in
                    MultipleChoiceButton(
                        title: category,
                        isSelected: selectedCategories.contains(category),
                        action: {
                            toggleSelection(for: category)
                        })
                }
                
                // Show recommended activities if categories are selected
                if !recommendedActivities.isEmpty {
                    Text("Recommended Activities")
                        .font(.custom("AvenirNext-Regular", size: 22))
                        .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                        .padding()
                    
                    ForEach(recommendedActivities, id: \.self) { activity in
                        Text(activity)
                            .font(.custom("AvenirNext-Regular", size: 22))
                            .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                            .padding()
                    }
                }
                
                Button(action: {
                    recommendActivities()
                }) {
                    Text("Get Recommendations")
                        .font(.custom("AvenirNext-Regular", size: 25))
                        .padding()
                        .background(Color(red: 67/255, green: 103/255, blue: 70/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
        }
    }
    
    private func toggleSelection(for category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
    
    private func recommendActivities() {
        recommendedActivities = []
        
        // Randomly select 2 activities for each selected category
        for category in selectedCategories {
            var categoryActivities: [String]
            
            switch category {
            case "Wellness & Relaxation":
                categoryActivities = ["Yoga Class", "Meditation & Mindfulness", "Spa & Hydrotherapy"]
            case "Outdoor & Nature":
                categoryActivities = ["Farm Tour", "Guided Nature Walk", "Fishing & Catch-Release", "Horseback Riding"]
            case "Culinary & Farm-to-Table":
                categoryActivities = ["Cooking Class", "Wine & Cheese Tasting", "Private Farm-to-Table Dining"]
            case "Adventure & Outdoor Sports":
                categoryActivities = ["Canoeing Experience", "Pickleball", "Axe Throwing", "Clay Shooting Course", "4-Wheeler Off-Roading"]
          //  case "Corporate & Events":
             //   categoryActivities = ["Corporate Retreat", "Conference Meeting", "Team Building Games", "Wedding & Event Space"]
            default:
                categoryActivities = []
            }
            
            // Randomly shuffle and pick two activities
            let randomActivities = categoryActivities.shuffled().prefix(2)
            recommendedActivities.append(contentsOf: randomActivities)
        }
    }
}

struct MultipleChoiceButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.1) : Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                Text(title)
                    .font(.custom("AvenirNext-Regular", size: 34))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()
            }
        }
        .padding(.horizontal, 40)
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRecs()
    }
}
