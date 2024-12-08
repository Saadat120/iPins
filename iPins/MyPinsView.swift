//
//  MyPinsView.swift
//  iPins
//
//  Created by Saadat Abbas on 12/7/24.
//

import SwiftUI

struct MyPinsView: View {
  // Access the ViewModel shared across the environment.
  @EnvironmentObject var mapModel: MapModel
  @EnvironmentObject var userSessionModel: UserSessionModel
  @Binding var events: Events
  @State private var showAuthSheet: Bool = false
  @State private var showRegistration: Bool = false

  var body: some View {
    ZStack{
      if userSessionModel.loggedIn{
        // Map Section
        MapView(mapModel: mapModel, userSessionModel: userSessionModel, events: $events)
          .ignoresSafeArea(.all)
      }
      else{
        VStack{
          Text("You Must Log in")
          Button(action: {showAuthSheet = true},
                 label: {Text("Login")} )
        }
      }
    }
    .sheet(isPresented: $showAuthSheet){
      LoginView()
        .presentationDetents([.large]) // Optional: Adjust height of the sheet
        .presentationDragIndicator(.visible)  // Optional: Add a drag indicator
    }
    .onAppear{
      if !userSessionModel.loggedIn{
        showAuthSheet = true
      }
    }
    .onChange(of: userSessionModel.loggedIn){ newvalue in
      if !newvalue{
        showAuthSheet = true
      }
    }
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
  
  MyPinsView(events: $allPins)
    .environmentObject(MapModel())
    .environmentObject(UserSessionModel())
}
