/*import SwiftUI
import MapKit

struct ExploreTheFarm: View {
    // Define the region for the map (Summers Branchville Farm, SC)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.3031, longitude: -80.6343), // Summers Branchville Farm coordinates
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack {
            //title
            Text("Explore the Farm")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            //buttons for Venues, Food, Activities
            VStack(spacing: 20) {
                Button(action: {
                    //venues button
                    print("Venues button tapped")
                }) {
                    Text("Venues")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }

                Button(action: {
                    //food button
                    print("Food button tapped")
                }) {
                    Text("Food")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }

                Button(action: {
                    //activity button
                    print("Activities button tapped")
                }) {
                    Text("Activities")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 20) //space between buttons and title

            Spacer() //push everything up

            //MAP
      //      Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
                .edgesIgnoringSafeArea(.bottom) //map fill screen
                .frame(maxHeight: .infinity)
                .padding(.top, 20)
        }
        .padding(.top, 20) //top of screen padding
    }
}

struct ExploreTheFarm_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTheFarm()
    }
}

struct ExploreTheFarmNav: View {
    var body: some View {
        VStack{
            ExploreTheFarm()
        }
        .navigationTitle("Explore the Farm")
    }
}*/

//LAYOUT 1
import SwiftUI
import MapKit

struct ExploreTheFarm: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.3031, longitude: -80.6343),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {

                // LOGO + HEADER
                VStack(spacing: 8) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)

                    Text("Explore the Farm")
                        .font(.custom("AvenirNext-Bold", size: 34))
                        .foregroundColor(Color(red: 59/255, green: 41/255, blue: 30/255).opacity(0.85))
                        .padding(.top, 20)

                    Capsule()
                        .frame(width: 60, height: 4)
                        .foregroundColor(Color(red: 228/255, green: 173/255, blue: 102/255))
                }
                .padding(.top)

                // BUTTONS
                VStack(spacing: 20) {
                    ExploreButton(title: "Venues") {
                        print("Venues button tapped")
                    }

                    ExploreButton(title: "Food") {
                        print("Food button tapped")
                    }

                    ExploreButton(title: "Activities") {
                        print("Activities button tapped")
                    }
                }
                .padding(.horizontal, 24)

                // OPTIONAL MAP
//                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
//                    .frame(height: 300)
//                    .cornerRadius(16)
//                    .padding(.horizontal, 24)
            }
            .padding(.bottom, 40)
        }
        .background(Color(red: 228/255, green: 173/255, blue: 102/255).opacity(0.03))
    }
}

// MARK: - Custom Styled Button
struct ExploreButton: View {
    var title: String
    var action: () -> Void
    var color: Color = Color(red: 67/255, green: 103/255, blue: 70/255).opacity(0.85)

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("AvenirNext-Regular", size: 34))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 130)
                .background(color)
                .cornerRadius(16)
                .shadow(radius: 2)
                .padding(.horizontal)
        }
    }
}




