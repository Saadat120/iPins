//
//  EventView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/17/24.
//

import SwiftUI
import MapKit

struct EventView: View {
   @State private var region = MKCoordinateRegion(
      center:CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
      span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
   )
   var body: some View {
      ScrollView {
         VStack(alignment: .leading, spacing: 20) {
            // Title
            Text("Pin Details")
               .font(.largeTitle)
               .bold()
               .padding(.horizontal)
            
            // Map Section
            ZStack {
               Map(coordinateRegion: $region, showsUserLocation: false, annotationItems: sampleLocations) { location in
                  MapMarker(coordinate: location.coordinate, tint: .blue)
               }
               .frame(height: 300) // Adjust height to fit your design
               .cornerRadius(10)
               .padding()
            }
            .padding(.horizontal)
            
            // Public Events Section
            SectionHeader(title: "Public Events")
            VStack(spacing: 10) {
               ForEach(0..<3, id: \.self) { _ in
                  EventRow(eventName: "Event Name", eventDetails: "Details about the event")
               }
            }
            .padding(.horizontal)
            
            // Saved Private Events Section
            SectionHeader(title: "Saved Private Events")
            VStack(spacing: 10) {
               ForEach(0..<3, id: \.self) { _ in
                  EventRow(eventName: "Private Event Name", eventDetails: "Details about private event")
               }
            }
            .padding(.horizontal)
            
            // Join Button
            Button(action: {
               print("Join button pressed")
            }) {
               Text("Join")
                  .font(.headline)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity)
                  .padding()
                  .background(Color.blue)
                  .cornerRadius(10)
                  .padding(.horizontal)
            }
         }
      }
   }
}

#Preview {
    EventView()
}
