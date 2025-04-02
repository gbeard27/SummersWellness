import SwiftUI

struct UserPreferencesView: View {
    @State private var selectedPreferences: Set<String> = []
    @State private var aiRecommendation: String = "Your recommendation will appear here."
    @State private var isLoading: Bool = false

    //List of all the options for the user to select
    let preferences = [
        "Rest and Recharge", "Stress Relief", "Mindfulness", "Digital detox", "Sleep improvement", "Deep Relaxation", "Solo Retreat", "Mental Clarity", "Emotional balance", "Managing anxiety", "Journaling and Reflection", "Self-Confidence", "Clean eating", "Learning healthy cooking", "Nutrition Education", "Starting a Wellness journey", "Holistic Health", "Whole body reset", "Plant-based learning", "Connecting with Nature", "Learning to grow food", "Connecting with Others", "Deepening friendships", "Quality time with family", "Couples' renewal", "Building Community"
    ]

    var body: some View {
            VStack {
                Text("Select Your Preferences")
                    .font(.custom("AvenirNext-Bold", size: 34))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                        ForEach(preferences, id: \.self) { preference in
                            Button(action: {
                                toggleSelection(for: preference)
                            }) {
                                Text(preference)
                                    .font(.custom("AvenirNext-Regular", size: 17))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedPreferences.contains(preference) ? Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.1) : Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }

                if isLoading {
                    ProgressView("Getting Recommendation...")
                        .font(.custom("AvenirNext-Regular", size: 22))
                        .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                        .padding()
                }

                Button(action: {
                    isLoading = true
                    fetchAIRecommendation(preferences: Array(selectedPreferences)) { result in
                        DispatchQueue.main.async {
                            aiRecommendation = result ?? "Something went wrong."
                            isLoading = false
                        }
                    }
                }) {
                    Text("Get Recommendation")
                        .font(.custom("AvenirNext-Regular", size: 22))
                        .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 67/255, green: 103/255, blue: 70/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }

                Text(aiRecommendation)
                    .font(.custom("AvenirNext-Regular", size: 17))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 129/255, green: 100/255, blue: 73/255).opacity(0.08))
                    .cornerRadius(10)
            }
            .padding()
            .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
        }

        private func toggleSelection(for preference: String) {
            if selectedPreferences.contains(preference) {
                selectedPreferences.remove(preference)
            } else {
                selectedPreferences.insert(preference)
            }
        }
    }

