//
//  FoodPreferences.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 3/27/25.
//

import SwiftUI

struct FoodPreferencesView: View {
    @State private var selectedPreferences: Set<String> = []
    @State private var aiRecommendation: String = "Your recommendation will appear here."
    @State private var isLoading: Bool = false


    //List of all the options for the user to select
    let preferences = [
        "Watermelons", "Blueberries", "Blackberries", "Strawberries", "Peppers", "Okra", "Collards", "Kyla", "Peaches", "Figs", "Persimmon", "Tomatoes", "Red Kuri Squash",
    ]

    var body: some View {
            VStack {
                Text("Select Your Preferences")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                        ForEach(preferences, id: \.self) { preference in
                            Button(action: {
                                toggleSelection(for: preference)
                            }) {
                                Text(preference)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedPreferences.contains(preference) ? Color.green : Color.gray.opacity(0.2))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }

                if isLoading {
                    ProgressView("Getting Recommendation...")
                        .padding()
                }

                Button(action: {
                    isLoading = true
                    fetchAIRecommendationFood(preferences: Array(selectedPreferences)) { result in
                        DispatchQueue.main.async {
                            aiRecommendation = result ?? "Something went wrong."
                            isLoading = false
                        }
                    }
                }) {
                    Text("Get Recommendation")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }

                Text(aiRecommendation)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding()
        }

        private func toggleSelection(for preference: String) {
            if selectedPreferences.contains(preference) {
                selectedPreferences.remove(preference)
            } else {
                selectedPreferences.insert(preference)
            }
        }
    }
