//
//  MapView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/22/24.
//

import SwiftUI
import MapKit
import RealmSwift

struct MapView: View {
  @ObservedObject var mapModel: MapModel
  @ObservedObject var userSessionModel: UserSessionModel
  @Binding var events: Events
  @State private var addPin = false
  @State var selectedPin: Pins?
  @ObservedResults(Pin.self) var pins
  
   var body: some View {
     ZStack {
       MapReader{ mapProxy in
         Map(position: $mapModel.cameraPosition, bounds: mapModel.bounds, interactionModes: .all, selection: $mapModel.selectedMapItem, scope: nil){
           
           UserAnnotation()
           // if the user has tapped on the map, show the location of the tap
           if let coordinate = mapModel.tappedCoordinate {
             if addPin == true{
               Marker("", systemImage: "pin.fill", coordinate: coordinate)
                 .tint(.purple)
             }
           }
           
           ForEach(events.eventPins) { item in
             Marker(item.name, coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
           } //end for each
         } //end map
         .onTapGesture(coordinateSpace: .local) { location in
           if let coordinate: CLLocationCoordinate2D = mapProxy.convert(location, from: .local){
             if addPin { mapModel.tappedCoordinate = coordinate }
           }
         } //end onTap
       } //end MapReader
       BottomView(pins: $events)
         .ignoresSafeArea()
       AddPinView(mapModel: mapModel, userSessionModel: userSessionModel, addPin: $addPin)
         .animation(.easeInOut, value: addPin)
         .transition(.move(edge: .bottom)) // Slide in/out from the bottom
       // Toolbar overlay

       //Plus Button
       VStack {
         HStack{
           Spacer()
           Button(action: {addPin.toggle() }, label: {
             Image(systemName: "plus")
               .padding()
               .background(Color.gray.opacity(0.7))
               .clipShape(RoundedRectangle(cornerRadius: 10))
           })
         } //end HStack
         .padding()
         Spacer()
       } //end VStack
     } //end ZStaCK
   } //end body
} //end struct


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
  MapView(mapModel: MapModel(), userSessionModel: UserSessionModel(), events: $allPins)
}

struct BottomView: View{
  @State private var searchText = ""
  @Binding var pins: Events
  var filteredEvents: [Pins] {
    if searchText.isEmpty{
      return Array(pins.eventPins)
    } else{
      return pins.eventPins
        .filter{ $0.name.localizedCaseInsensitiveContains(searchText)}
    }
  }
  
  @State private var offsetY: CGFloat = UIScreen.main.bounds.height/2.25 // Initial Offset
  @State private var dragOffset: CGFloat = 0 //offset during dragging
  let expandedHeight: CGFloat = 100  // Expanded position
  let initialHeight: CGFloat = UIScreen.main.bounds.height/2.25
  let collapsedHeight: CGFloat = UIScreen.main.bounds.height - 150 // Collapsed position
  
  var body: some View{
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
          Text(pins.name)
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
    .offset(
      y: max(min(offsetY + dragOffset, collapsedHeight), expandedHeight)
    )
    .gesture(
      DragGesture()
        .onChanged{ value in
          dragOffset = value.translation.height
        }
        .onEnded{ value in
          let newOffset = offsetY + dragOffset
          let closestPosition = getClosestPosition(for: newOffset)
          offsetY = closestPosition
          dragOffset = 0 // Reset drag offset
        }
    ) .animation(.easeInOut, value: dragOffset)
  }
  private func getClosestPosition(for currentOffset: CGFloat) -> CGFloat {
    let positions = [expandedHeight, initialHeight, collapsedHeight]
    return positions.min(by: { abs($0 - currentOffset) < abs($1 - currentOffset) }) ?? initialHeight
  } //end func
}
