//
//  EventView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/17/24.
//

import SwiftUI

struct EventView: View {
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
    ZStack {
      // Map Section
      MapView(events: $events)
        .ignoresSafeArea(.all)
      
      VStack(spacing: 0) {
        Capsule()
          .frame(width: 40, height: 5)
          .foregroundStyle(.gray)
          .padding(.top, 10)
        
        HStack{
          TextField("Search Events...", text: $searchText)
            .padding(8)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal)
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        
        ScrollView{
          VStack(alignment: .leading, spacing: 10){
            Text(events.name)
              .font(.title2)
              .bold()
              .padding(.horizontal)
            
            ForEach(Array(filteredEvents), id: \.self) { item in
              EventRow( eventName: item.name, eventDetails: item.details)
            }
          }
          .padding()
          
        } //end ScrollView
      } //end VStack
      .frame(maxWidth: .infinity)
      .background(Color(.systemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .shadow(radius: 5)
      .offset(y: max(min(offsetY + dragOffset, maxHeight), minHeight))
      .gesture(
        DragGesture()
          .onChanged{ value in
            dragOffset = value.translation.height
          }
          .onEnded{ value in
            if dragOffset > 50{
              // Dragged down: collapse the section
              offsetY = maxHeight
            } else if dragOffset < -100 {
              // Dragged up: expand the section
              offsetY = minHeight
            }
            dragOffset = 0 // Reset drag offset
          }
      ) .animation(.easeInOut, value: dragOffset)
    } //end ZStack
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
  }
