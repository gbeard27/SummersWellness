//
//  PhotoGallery.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 3/11/25.
//

import SwiftUI

struct ResortPhotoGallery: View {
    /*@State private var selectedArea: String = "Outdoors"
    @State private var areas = [
        "Outdoors": ["TreesFarm", "ChapelFarm", "OutdoorsFarm", "TreesFarm"],
        "Farm": ["download", "ChapelFarm", "OutdoorsFarm"],
        "Garden": ["download", "ChapelFarm", "OutdoorsFarm", "TreesFarm"],
        "Barn": ["OutdoorsFarm", "TreesFarm", "download", "ChapelFarm"],
        "Ballroom": ["download", "TreesFarm","ChapelFarm", "OutdoorsFarm"]
    ]*/
    
    @State private var selectedArea: String = "Outdoors"
    @State private var areas = [
        "Outdoors": ["outdoor1", "outdoor2", "outdoor3"],
        "Farm": ["farm1","farm2","farm3"],
        "Garden": ["garden1","garden2","garden3"],
        "Barn": ["download-1","download 2", "barn2","barn3" ],
        "Ballroom": ["ChapelFarm", "download-6", "download-8"],
        "All": ["outdoor1", "outdoor2", "outdoor3", "farm1","farm2","farm3", "garden1","garden2","garden3", "download-1","download 2", "barn2","barn3", "ChapelFarm", "download-6", "download-8"]
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
