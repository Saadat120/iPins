//
//  ContentView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/15/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
  @State private var showMenu = false
  @State private var selectedTab = 0
  @State private var myPins = Events(name: "My Pins")
  @State private var savedPins = Events(name: "Saved Pins")
  @State private var allPins = Events(name: "All Pins", eventPins: [Pins(name: "Central Park", details: "Link Up", latitude: 40.7851, longitude: -73.9683, attendees: 1, Public: true), Pins(name: "Statue of Liverty", details: "Link Up", latitude: 40.6892, longitude: -74.0445, attendees: 2, Public: true), Pins(name: "Times Square", details: "Link Up", latitude: 40.7580, longitude: -73.9855, attendees: 20, Public: true)])
  //  @State private var searchText = ""
  //
  //  var filteredEvents: [Pins] {
  //    if searchText.isEmpty{
  //      return Array(allPins.eventPins)
  //    } else{
  //      return allPins.eventPins
  //        .filter{ $0.name.localizedCaseInsensitiveContains(searchText)}
  //    }
  //  }
  //
  //  @State private var offsetY: CGFloat = UIScreen.main.bounds.height/2.25 // Initial Offset
  //  @State private var dragOffset: CGFloat = 0 //offset during dragging
  //  let expandedHeight: CGFloat = 100  // Expanded position
  //  let initialHeight: CGFloat = UIScreen.main.bounds.height/2.25
  //  let collapsedHeight: CGFloat = UIScreen.main.bounds.height - 150 // Collapsed position
  //
  var body: some View {
    NavigationStack {
      ZStack{
        TabView(selection: $selectedTab){
          MapView(events: $allPins)
            .ignoresSafeArea(edges: .all)
            .tag(0)
          
          EventView(events: $allPins)
            .ignoresSafeArea()
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
              if selectedTab == 0{
                Button(action: {  }) {
                  Image(systemName: "plus")
                    .padding()
                    .background(Color.gray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
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
    //    ZStack {
    //      // Map Section
    //      MapView(events: $allPins)
    //        .ignoresSafeArea(.all)
    //
    //      VStack(spacing: 0) {
    //        Capsule()
    //          .frame(width: 40, height: 5)
    //          .foregroundStyle(.gray)
    //          .padding(.top, 10)
    //
    //        HStack{
    //          TextField("Search Events...", text: $searchText)
    //            .padding(8)
    //            .background(Color(.systemGray6))
    //            .clipShape(RoundedRectangle(cornerRadius: 8))
    //            .padding(.horizontal)
    //        }
    //        .padding(.top, 10)
    //        .padding(.bottom, 20)
    //
    //        ScrollView{
    //          VStack(alignment: .leading, spacing: 10){
    //            Text(allPins.name)
    //              .font(.title2)
    //              .bold()
    //              .padding(.horizontal)
    //
    //            ForEach(Array(filteredEvents), id: \.self) { item in
    //              EventRow( eventName: item.name, eventDetails: item.details)
    //            }
    //          }
    //          .padding()
    //
    //        } //end ScrollView
    //      } //end VStack
    //      .frame(maxWidth: .infinity)
    //      .background(Color(.systemBackground))
    //      .clipShape(RoundedRectangle(cornerRadius: 20))
    //      .shadow(radius: 5)
    //      .offset(
    //        y: max(min(offsetY + dragOffset, collapsedHeight), expandedHeight)
    //      )
    //      .gesture(
    //        DragGesture()
    //          .onChanged{ value in
    //            dragOffset = value.translation.height
    //          }
    //          .onEnded{ value in
    //            let newOffset = offsetY + dragOffset
    //            let closestPosition = getClosestPosition(for: newOffset)
    //            offsetY = closestPosition
    //            dragOffset = 0 // Reset drag offset
    //          }
    //      ) .animation(.easeInOut, value: dragOffset)
    //    } //end ZStack
  }//end body
  //  private func getClosestPosition(for currentOffset: CGFloat) -> CGFloat {
  //    let positions = [expandedHeight, initialHeight, collapsedHeight]
  //    return positions.min(by: { abs($0 - currentOffset) < abs($1 - currentOffset) }) ?? initialHeight
  //  } //end func
}//end Struct

#Preview {
  ContentView()
}



//    NavigationStack {
//      ZStack{
//        TabView(selection: $selectedTab){
//          MapView(events: $allPins)
//            .ignoresSafeArea(edges: .all)
//            .tag(0)
//
//          EventView(events: $allPins)
//            .ignoresSafeArea()
//            .tag(1)
//
//          Text("Random")
//            .tag(2)
//
//          Text("Random")
//            .tag(3)
//        }
//        .tabViewStyle(.page(indexDisplayMode: .never))
//        .ignoresSafeArea()
//        SideView(isShowing: $showMenu, selectedTab: $selectedTab)
//
//        // Toolbar overlay
//        if !showMenu {
//          VStack {
//            HStack {
//              Button(action: { showMenu.toggle() }) {
//                Image(systemName: "line.3.horizontal")
//                  .padding()
//                  .background(Color.gray.opacity(0.7))
//                  .clipShape(RoundedRectangle(cornerRadius: 10))
//
//              }
//              Spacer()
//              if selectedTab == 0{
//                Button(action: {  }) {
//                  Image(systemName: "plus")
//                    .padding()
//                    .background(Color.gray.opacity(0.7))
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
//              }
//            }
//            .padding()
//            Spacer()
//          }
//        }
//      }//end ZStack
//      .toolbar(.hidden, for: .navigationBar)
//
//    }//end NavigationStack
//    .ignoresSafeArea(edges:.all)
