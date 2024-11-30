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
   @State private var showMenu = false
   @State private var selectedTab = 0
   @State private var myPins = Events()
   @State private var savedPins = Events()
   @State private var allPins = Events(eventPins: [Pins(name: "Central Park", details: "Link Up", latitude: 40.7851, longitude: -73.9683, attendees: 1, Public: true), Pins(name: "Statue of Liverty", details: "Link Up", latitude: 40.6892, longitude: -74.0445, attendees: 2, Public: true), Pins(name: "Times Square", details: "Link Up", latitude: 40.7580, longitude: -73.9855, attendees: 20, Public: true)])
   var body: some View{
      NavigationStack {
         ZStack{
            TabView(selection: $selectedTab){
               MapView(events: $allPins)
                  .ignoresSafeArea(edges: .all)
                  .tag(0)
               
               Text("Random")
                  .tag(1)
               
               Text("Random")
                  .tag(2)
               
               Text("Random")
                  .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
               SideView(isShowing: $showMenu, selectedTab: $selectedTab)
               
               // Toolbar overlay
               if !showMenu {
                  VStack {
                     HStack {
                        Button(action: { showMenu.toggle() }) {
                           Image(systemName: "line.3.horizontal")
                              .padding()
                              .background(Color.gray.opacity(0.7))
                              .clipShape(RoundedRectangle(cornerRadius: 10))
                           
                        }
                        Spacer()
                        
                        Button(action: {  }) {
                           Image(systemName: "plus")
                              .padding()
                              .background(Color.gray.opacity(0.7))
                              .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                     }
                     .padding()
                     Spacer()
                  }
               }
         }//end ZStack
         .toolbar(.hidden, for: .navigationBar)
         
      }//end NavigationStack
      .ignoresSafeArea(edges:.all)

   }//end body
}//end Struct

#Preview {
    ContentView()
}
