//
//  ContentView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/15/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
  @EnvironmentObject var mapModel: MapModel
  @EnvironmentObject var userSessionModel: UserSessionModel
  @State private var showMenu = false
  @State private var addPin = false
  @State private var selectedTab = 0
  @State private var myPins = Events(name: "My Pins")
  @State private var savedPins = Events(name: "Saved Pins")
  @State private var allPins = Events(name: "All Pins", eventPins: [Pins(name: "Central Park", details: "Link Up", latitude: 40.7851, longitude: -73.9683, attendees: 1, Public: true), Pins(name: "Statue of Liberty", details: "Link Up", latitude: 40.6892, longitude: -74.0445, attendees: 2, Public: true), Pins(name: "Times Square", details: "Link Up", latitude: 40.7580, longitude: -73.9855, attendees: 20, Public: true)])
  var body: some View {

        TabView(selection: $selectedTab){
          MapView(mapModel: mapModel, userSessionModel: userSessionModel, events: $allPins)
            .tabItem {
              Label("All Pins", systemImage: "map")
            }
            .tag(0)
          MyPinsView(events: $allPins)
            .tabItem {
              Label("MyPins", systemImage: "mappin.and.ellipse")
            }
            .tag(1)
          
          Text("Random")
            .tabItem {
              Label("Chat", systemImage: "bubble.fill")
            }
            .tag(2)
          
          Text("Settings")
            .tabItem {
              Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(3)
        }
        .ignoresSafeArea()
  }//end body
}//end Struct

#Preview {
  ContentView()
    .environmentObject(MapModel())
    .environmentObject(UserSessionModel())
}
