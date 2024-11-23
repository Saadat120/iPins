//
//  ContentView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/15/24.
//

import SwiftUI
import MapKit

// Sample locations in NYC for map markers
struct Location: Identifiable {
   let id = UUID()
   let name: String
   let coordinate: CLLocationCoordinate2D
}

// Sample locations (e.g., landmarks or events)
let sampleLocations = [
   Location(name: "Central Park", coordinate: CLLocationCoordinate2D(latitude: 40.7851, longitude: -73.9683)),
   Location(name: "Statue of Liberty", coordinate: CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.0445)),
   Location(name: "Times Square", coordinate: CLLocationCoordinate2D(latitude: 40.7580, longitude: -73.9855))
]

struct ContentView: View {
   @State private var region = MKCoordinateRegion(
      center:CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
      span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
   )
   var body: some View{
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

struct SectionHeader: View {
   let title: String
   
   var body: some View {
      Text(title)
         .font(.title2)
         .bold()
         .padding(.horizontal)
   }
}

struct EventRow: View {
   let eventName: String
   let eventDetails: String
   
   var body: some View {
      HStack {
         Circle()
            .fill(Color.blue)
            .frame(width: 40, height: 40)
            .overlay(
               Image(systemName: "mappin.and.ellipse")
                  .foregroundColor(.white)
            )
         VStack(alignment: .leading) {
            Text(eventName)
               .font(.headline)
            Text(eventDetails)
               .font(.subheadline)
               .foregroundColor(.gray)
         }
         Spacer()
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(10)
   }
}

#Preview {
    ContentView()
}
