//
//  CalorieCalc.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 3/26/25.
//

import SwiftUI

struct CalorieTrackerForm: View {
    @State private var showingPopup = false
    @State private var isLoading = false
    @State private var resultText: String? = nil

    @State private var age: Int = 25
    @State private var gender: String = "Male"
    @State private var height: Double = 72
    @State private var weight: Double = 150

    @State private var expandedActivities: Set<String> = []
    @State private var selectedActivities: Set<String> = []
    @State private var activityDurations: [String: Int] = [:]
    @State private var activityIntensity: [String: String] = [:]

    @State private var breakfast: String = ""
    @State private var lunch: String = ""
    @State private var dinner: String = ""
    @State private var snack: String = ""

    let genderOptions = ["Male", "Female", "Other"]
    let resortActivities = [
        "Yoga",
        "Pilates",
        "Nature Walk / Hike",
        "Strength Training",
        "Meditation",
        "Farm Tour",
        "Swimming",
        "Cycling",
        "Cooking Class"
    ]
    let intensityOptions = ["Light", "Moderate", "Vigorous"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // 🌟 User Info
                    GroupBox(label: Label("Your Info", systemImage: "person.fill")) {
                        VStack(spacing: 10) {
                            Stepper("Age: \(age)", value: $age, in: 5...100)
                            Text("Gender")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Picker("Gender", selection: $gender) {
                                ForEach(genderOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())


                            HStack {
                                Text("Height (in)")
                                Spacer()
                                TextField("Height", value: $height, format: .number)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }

                            HStack {
                                Text("Weight (lbs)")
                                Spacer()
                                TextField("Weight", value: $weight, format: .number)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        .padding(.top, 5)
                    }

                    // 💪 Activities
                    GroupBox(label: Label("Today's Activities", systemImage: "flame.fill")) {
                        ForEach(resortActivities, id: \.self) { activity in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(activity)
                                        .font(.headline)
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            if expandedActivities.contains(activity) {
                                                expandedActivities.remove(activity)
                                                selectedActivities.remove(activity)
                                            } else {
                                                expandedActivities.insert(activity)
                                                selectedActivities.insert(activity)
                                            }
                                        }
                                    }) {
                                        Image(systemName: expandedActivities.contains(activity) ? "chevron.down" : "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                }

                                if expandedActivities.contains(activity) {
                                    VStack(alignment: .leading) {
                                        Stepper("Duration: \(activityDurations[activity, default: 30]) min", value: Binding(get: {
                                            activityDurations[activity, default: 30]
                                        }, set: { newValue in
                                            activityDurations[activity] = newValue
                                        }), in: 1...240)

                                        Picker("Intensity", selection: Binding(get: {
                                            activityIntensity[activity, default: "Moderate"]
                                        }, set: { newValue in
                                            activityIntensity[activity] = newValue
                                        })) {
                                            ForEach(intensityOptions, id: \.self) {
                                                Text($0)
                                            }
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                                    }
                                    .padding(.leading, 10)
                                }

                                Divider()
                            }
                        }
                    }

                    // 🍽️ Meals
                    GroupBox(label: Label("Today's Meals", systemImage: "fork.knife")) {
                        VStack(alignment: .leading, spacing: 15) {
                            MealEntry(title: "Breakfast", mealText: $breakfast)
                            MealEntry(title: "Lunch", mealText: $lunch)
                            MealEntry(title: "Dinner", mealText: $dinner)
                            MealEntry(title: "Snack", mealText: $snack)
                        }
                    }

                    // ✅ Submit Button
                    Button(action: {
                        // 1. Print to Terminal
                        printSummary()

                        // 2. Send POST Request
                        sendCalorieData(
                            age: age,
                            gender: gender,
                            height: height,
                            weight: weight,
                            selectedActivities: selectedActivities,
                            activityDurations: activityDurations,
                            activityIntensity: activityIntensity,
                            breakfast: breakfast,
                            lunch: lunch,
                            dinner: dinner,
                            snack: snack
                        ) { result in
                            switch result {
                            case .success(let message):
                                print("✅ POST Success: \(message)")
                            case .failure(let error):
                                print("❌ POST Failed: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                    }


                }
                .padding()
            }
            .navigationTitle("Calorie Tracker")
        }
    }
    func printSummary() {
        print("USER INFO")
        print("Age: \(age)")
        print("Gender: \(gender)")
        print("Height: \(height) cm")
        print("Weight: \(weight) kg")

        print("\n SELECTED ACTIVITIES")
        for activity in selectedActivities {
            let duration = activityDurations[activity, default: 30]
            let intensity = activityIntensity[activity, default: "Moderate"]
            print("Activity: \(activity) — Duration: \(duration) min — Intensity: \(intensity)")
        }

        print("\n MEALS")
        print("Breakfast: \(breakfast)")
        print("Lunch: \(lunch)")
        print("Dinner: \(dinner)")
        print("Snack: \(snack)")
    }

}

struct MealEntry: View {
    var title: String
    @Binding var mealText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            TextField("What did you eat?", text: $mealText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

#Preview {
    CalorieTrackerForm()
}
