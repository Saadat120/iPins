//
//  AddPinView.swift
//  iPins
//
//  Created by Saadat Abbas on 12/2/24.
//

import SwiftUI
import RealmSwift

struct AddPinView: View {
  @Binding var addPin: Bool
  @State private var name: String = ""
  @State private var details: String = ""
//  @State private var latitude: Double
//  @State private var longitude: Double
  @State private var attendees: String = ""
  @State private var isPublic: Bool = true
  
  @ObservedResults(Pin.self) var pins
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    if addPin{
      VStack(spacing: 30){
        HStack(spacing: 75){
          Button(action: { addPin.toggle() }, label: {Text("Cancel")})
          Text("New Pin")
          Button(action: { addPin.toggle() }, label: {Text("Add") })
        }
        
        Form{
          TextField("Enter Pin Name", text: $name)
          TextField("Enter Pin detail", text: $details)
          TextField("Enter Number of Attendees", text: $attendees)
            .keyboardType(.numberPad)
          Toggle("Public", isOn: $isPublic)
          Button(
            action: {
              let pin = Pin()
              pin.name = name
              pin.details = details
              pin.attendees = Int(attendees) ?? 0
              pin.isPublic = isPublic
              dismiss()
              
              $pins.append(pin)
            },
            label: { Text("Save")}).buttonStyle(.bordered)
        }
      }
      .presentationDetents([.medium, .large])
    }
  }
}

#Preview {
  AddPinView( addPin: .constant(true))
}


//struct BottomhView: View{
//  
//  @State private var offsetY: CGFloat = UIScreen.main.bounds.height/2.25 // Initial Offset
//  @State private var dragOffset: CGFloat = 0 //offset during dragging
//  let expandedHeight: CGFloat = 100  // Expanded position
//  let initialHeight: CGFloat = UIScreen.main.bounds.height/2.25
//  let collapsedHeight: CGFloat = UIScreen.main.bounds.height - 150 // Collapsed position
//  
//  var body: some View{
//    VStack(spacing: 0) {
//      Capsule()
//        .frame(width: 40, height: 5)
//        .foregroundStyle(.gray)
//        .padding(.top, 10)
//      
//      HStack{
//        TextField("Search Events...", text: $searchText)
//          .padding(8)
//          .background(Color(.systemGray6))
//          .clipShape(RoundedRectangle(cornerRadius: 8))
//          .padding(.horizontal)
//      }
//      .padding(.top, 10)
//      .padding(.bottom, 20)
//      
//      ScrollView{
//        VStack(alignment: .leading, spacing: 10){
//          Text(pins.name)
//            .font(.title2)
//            .bold()
//            .padding(.horizontal)
//          
//          ForEach(Array(filteredEvents), id: \.self) { item in
//            EventRow( eventName: item.name, eventDetails: item.details)
//          }
//        }
//        .padding()
//        
//      } //end ScrollView
//    } //end VStack
//    .frame(maxWidth: .infinity)
//    .background(Color(.systemBackground))
//    .clipShape(RoundedRectangle(cornerRadius: 20))
//    .shadow(radius: 5)
//    .offset(
//      y: max(min(offsetY + dragOffset, collapsedHeight), expandedHeight)
//    )
//    .gesture(
//      DragGesture()
//        .onChanged{ value in
//          dragOffset = value.translation.height
//        }
//        .onEnded{ value in
//          let newOffset = offsetY + dragOffset
//          let closestPosition = getClosestPosition(for: newOffset)
//          offsetY = closestPosition
//          dragOffset = 0 // Reset drag offset
//        }
//    ) .animation(.easeInOut, value: dragOffset)
//  }
//  private func getClosestPosition(for currentOffset: CGFloat) -> CGFloat {
//    let positions = [expandedHeight, initialHeight, collapsedHeight]
//    return positions.min(by: { abs($0 - currentOffset) < abs($1 - currentOffset) }) ?? initialHeight
//  } //end func
//}
