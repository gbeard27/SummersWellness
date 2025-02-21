//
//  BookActivities.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 2/21/25.
//
import SwiftUI
struct ScrollableOption: Identifiable {
    let id = UUID()
    let image: String
    let text: String
}

struct HorizontalScrollBar: View {
    let title: String
    let options: [ScrollableOption]
    let onSelect: (ScrollableOption) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 16)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(options) { option in
                        OptionView(option: option)
                            .onTapGesture {
                                onSelect(option)
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(height: 200)
    }
}

struct OptionView: View {
    let option: ScrollableOption
    
    var body: some View {
        VStack {
            Image(systemName: option.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            
            Text(option.text)
                .font(.callout)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
    }
}

struct ContentViewCards: View {
    let options = [
        ScrollableOption(image: "figure.cooldown", text: "Cooldown"),
        ScrollableOption(image: "figure.run", text: "Run"),
        ScrollableOption(image: "figure.walk", text: "Walk"),
        ScrollableOption(image: "figure.core.training", text: "Core"),
        ScrollableOption(image: "figure.cross.training", text: "Cross Fit"),
        ScrollableOption(image: "figure.flexibility", text: "Stretching"),
        ScrollableOption(image: "figure.strength.training", text: "Strength")
    ]
    let options1 = [
        ScrollableOption(image: "car", text: "Test"),
        ScrollableOption(image: "airplane", text: "Test"),
        ScrollableOption(image: "sailboat", text: "Test"),
        ScrollableOption(image: "ferry", text: "Test"),
        ScrollableOption(image: "scooter", text: "Test"),
        ScrollableOption(image: "ferry", text: "Test"),
        ScrollableOption(image: "scooter", text: "Test")
    ]
    let options2 = [
        ScrollableOption(image: "apple.meditate", text: "Meditate"),
        ScrollableOption(image: "brain", text: "Test"),
        ScrollableOption(image: "pill", text: "Test"),
        ScrollableOption(image: "cross", text: "Test"),
        ScrollableOption(image: "heart", text: "Test"),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Fixed title at the top
            Text("Book Activities")
                .font(.system(size: 100))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
            
            // Scrollable content
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    HorizontalScrollBar(title: "Workout activities", options: options) { selectedOption in
                        print("Selected Outdoor: \(selectedOption.text)")
                    }
                    HorizontalScrollBar(title: "Outdoor Activities", options: options1) { selectedOption in
                        print("Selected Indoor: \(selectedOption.text)")
                    }
                    HorizontalScrollBar(title: "Wellness", options: options2) { selectedOption in
                        print("Selected Wellness: \(selectedOption.text)")
                    }
                    HorizontalScrollBar(title: "Farm Tours", options: options1) { selectedOption in
                        print("Selected Tour: \(selectedOption.text)")
                    }
                }
                .padding(.top)
            }
        }
        .edgesIgnoringSafeArea(.top) // This ensures the title extends to the top of the screen
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCards()
    }
}
