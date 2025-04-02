//
//  PhotoGallery.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 3/11/25.
//

import SwiftUI

struct ResortPhotoGallery: View {
    @State private var selectedArea: String = "Outdoors"
    @State private var areas = [
        "Outdoors": ["TreesFarm", "ChapelFarm", "OutdoorsFarm", "TreesFarm"],
        "Farm": ["download", "ChapelFarm", "OutdoorsFarm"],
        "Garden": ["download", "ChapelFarm", "OutdoorsFarm", "TreesFarm"],
        "Barn": ["OutdoorsFarm", "TreesFarm", "download", "ChapelFarm"],
        "Ballroom": ["download", "TreesFarm","ChapelFarm", "OutdoorsFarm"]
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Text("Resort Photo Gallery")
                    .font(.custom("AvenirNext-Bold", size: 34))
                    .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                    .padding()

                Picker("Select Area", selection: $selectedArea) {
                    ForEach(areas.keys.sorted(), id: \.self) { area in
                        Text(area).tag(area)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                        ForEach(areas[selectedArea] ?? [], id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipped()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Explore the Resort")
        }
    }
}

#Preview {
    ResortPhotoGallery()
}
