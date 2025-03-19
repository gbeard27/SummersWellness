import SwiftUI

struct GuestPreferences: Identifiable, Codable {
    let id = UUID()
    var name: String
    var allergies: String
    var diets: [String]
    var specialRequests: String
}

class GuestPreferencesViewModel: ObservableObject {
    @Published var guests: [GuestPreferences] = []
    
    func addGuest(name: String, allergies: String, diets: [String], specialRequests: String) {
        let newGuest = GuestPreferences(name: name, allergies: allergies, diets: diets, specialRequests: specialRequests)
        guests.append(newGuest)
    }
}

struct FoodFormView: View {
    @State private var name = ""
    @State private var allergies = ""
    @State private var specialRequests = ""
    @State private var selectedDiets: Set<String> = []
    @State private var customDiet = ""
    
    @ObservedObject var viewModel: GuestPreferencesViewModel
    
    let dietOptions = ["Vegan", "Gluten Free", "Pescatarian", "Other"]
    
    var body: some View {
        Form {
            // Guest Name Section
            Section(header: Text("Guest Information")) {
                TextField("Name", text: $name)
                    .padding(.bottom, 10)
            }
            .padding(.bottom, 20) // Adds space below the Name section
            
            // Allergies Section
            Section(header: Text("Dietary Preferences")) {
                TextField("Allergies", text: $allergies)
                    .padding(.bottom, 10)
            }
            .padding(.bottom, 20) // Adds space below the Allergies section
            
            // Diet Selection Section
            Section(header: Text("Select Your Diet Preferences")) {
                // Diet checkboxes for multiple selections
                ForEach(dietOptions, id: \.self) { option in
                    Toggle(option, isOn: Binding(
                        get: { self.selectedDiets.contains(option) },
                        set: { isSelected in
                            if isSelected {
                                self.selectedDiets.insert(option)
                            } else {
                                self.selectedDiets.remove(option)
                            }
                        }
                    ))
                    .padding(.bottom, 5)
                }
                
                if selectedDiets.contains("Other") {
                    TextField("Please specify", text: $customDiet)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                }
            }
            .padding(.bottom, 20) // Adds space below the Diet section
            
            // Special Requests Section
            Section(header: Text("Special Requests")) {
                TextField("Special Requests", text: $specialRequests)
                    .padding(.bottom, 10)
            }
            .padding(.bottom, 20) // Adds space below the Special Requests section
            
            // Submit Button Section
            Button("Submit") {
                // Collect all selected diet options, including custom input if "Other" is selected
                var finalDiets = Array(selectedDiets)
                if selectedDiets.contains("Other"), !customDiet.isEmpty {
                    finalDiets.append(customDiet)
                }
                
                viewModel.addGuest(name: name, allergies: allergies, diets: finalDiets, specialRequests: specialRequests)
                
                // Clear fields after submission
                name = ""
                allergies = ""
                specialRequests = ""
                selectedDiets.removeAll()
                customDiet = ""
            }
            .padding(.top, 10)
        }
        .navigationTitle("Food Form")
    }
}

struct DashboardFoodView: View {
    @ObservedObject var viewModel: GuestPreferencesViewModel
    
    var body: some View {
        List(viewModel.guests) { guest in
            VStack(alignment: .leading) {
                Text(guest.name).font(.headline)
                Text("Allergies: \(guest.allergies)").font(.subheadline)
                Text("Diets: \(guest.diets.joined(separator: ", "))").font(.subheadline)
                Text("Special Requests: \(guest.specialRequests)").font(.subheadline)
            }
            .padding()
        }
        .navigationTitle("Guest Dashboard")
    }
}




