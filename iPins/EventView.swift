//
//  EventView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/17/24.
//

import SwiftUI

struct EventView: View {
  // Access the ViewModel shared across the environment.
  @EnvironmentObject var mapModel: MapModel
  @EnvironmentObject var userSessionModel: UserSessionModel
  @Binding var events: Events
  @State private var searchText = ""
  
  var filteredEvents: [Pins] {
    if searchText.isEmpty{
      return Array(events.eventPins)
    } else{
      return events.eventPins.filter{ $0.name.localizedCaseInsensitiveContains(searchText)}
    }
  }
  
  @State private var offsetY: CGFloat = UIScreen.main.bounds.height/2 // Initial Offset
  @State private var dragOffset: CGFloat = 0 //offset during dragging
  let minHeight: CGFloat = 100  // Expanded position
  let maxHeight: CGFloat = UIScreen.main.bounds.height - 150 // Collapsed position

  var body: some View {
    
      // Map Section
    MapView(mapModel: mapModel, userSessionModel: userSessionModel, events: $events)
        .ignoresSafeArea(.all)
    
  } //end body
} //end View
  
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
    @Previewable @State var allPins = Events(
      name: "All Pins",
      eventPins: [
        Pins(
          name: "Central Park",
          details: "Link Up",
          latitude: 40.7851,
          longitude: -73.9683,
          attendees: 1,
          Public: true
        ),
        Pins(
          name: "Statue of Liverty",
          details: "Link Up",
          latitude: 40.6892,
          longitude: -74.0445,
          attendees: 2,
          Public: true
        ),
        Pins(
          name: "Times Square",
          details: "Link Up",
          latitude: 40.7580,
          longitude: -73.9855,
          attendees: 20,
          Public: true
        )
      ]
    )
    EventView(events: $allPins)
      .environmentObject(MapModel())
      .environmentObject(UserSessionModel())
  }
