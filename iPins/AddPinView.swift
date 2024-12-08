//
//  AddPinView.swift
//  iPins
//
//  Created by Saadat Abbas on 12/2/24.
//

import SwiftUI
import RealmSwift

struct AddPinView: View {
  @ObservedObject var mapModel: MapModel
  @ObservedObject var userSessionModel: UserSessionModel
  @State private var offsetY: CGFloat = UIScreen.main.bounds.height/2 // Initial Offset
  let initialHeight: CGFloat = UIScreen.main.bounds.height/3
  @Binding var addPin: Bool
  @State private var showLogin: Bool = false
  @State private var name: String = ""
  @State private var details: String = ""
  @State private var longitude: Double = 0
  @State private var latitude: Double = 0
  @State private var attendees: String = ""
  @State private var isPublic: Bool = true

  @ObservedResults(Pin.self) var pins
  
  var body: some View {
    ZStack{
      if addPin && userSessionModel.loggedIn{
        VStack(spacing: 20){
          Spacer()
          HStack(spacing: 80){
            Button(action: { addPin.toggle() }, label: {Text("Cancel")})
            Text("New Pin")
            Button(action: { sendPinData(); addPin.toggle() }, label: {Text("Add") })
          }
          Form{
            TextField("Enter Pin Name", text: $name)
            TextArea("Enter Pin Details", text: $details)
            Text("Longitude: \(String(Double(mapModel.tappedCoordinate?.longitude ?? 0)))")
              .padding(.vertical, 6)
            Text("Latitude: \(String(Double(mapModel.tappedCoordinate?.latitude ?? 0)))")
              .padding(.vertical, 6)
            TextField("Enter Number of Attendees", text: $attendees)
              .keyboardType(.numberPad)
              .padding(.vertical, 6)
            Toggle("Public", isOn: $isPublic)
          } //end Form
          .clipShape(RoundedRectangle(cornerRadius: 10))
        } //end VStack
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .offset(y: initialHeight)
        .transition(.move(edge: .bottom)) // Slide in/out from the bottom
        .animation(.easeInOut, value: addPin) // Smooth animation
      } //end if
    }.sheet(isPresented: $showLogin){
      LoginView()
        .presentationDetents([.large]) // Optional: Adjust height of the sheet
        .presentationDragIndicator(.visible)  // Optional: Add a drag indicator
    }
    .onChange(of: addPin) { newValue in
      // Show login sheet if the user is not logged in
      if newValue && !userSessionModel.loggedIn {
        showLogin = true
      }
    }
  } //end body
  private func sendPinData(){
    if !name.isEmpty && !details.isEmpty  && !attendees.isEmpty{
      if Double(mapModel.tappedCoordinate?.longitude ?? 0) != 0 && Double(mapModel.tappedCoordinate?.latitude ?? 0) != 0{
        let pin = Pin()
        pin.name = name
        pin.details = details
        pin.attendees = Int(attendees) ?? 0
        pin.isPublic = isPublic
        pin.latitude = Double(mapModel.tappedCoordinate?.latitude ?? 0)
        pin.longitude = Double(mapModel.tappedCoordinate?.longitude ?? 0)
        
        $pins.append(pin)
      } //end inner if
    } //end outer if
  } //end func sendPinData
} //end struct

//custom text area for body
struct TextArea: View{
  @Binding var text: String
  let placeholder: String
  
  init(_ placeholder: String, text: Binding<String>) {
    self.placeholder = placeholder
    self._text = text
  }
  
  var body: some View{
    ZStack(alignment: .topLeading){
      if text.isEmpty{
        Text(placeholder)
          .foregroundColor(Color(.placeholderText))
      }
      
      TextEditor(text: $text)
        .textFieldStyle(.roundedBorder)
        .scrollContentBackground(.hidden)
        .font(.title3)
    } // end ZStack
    .font(.body)
  }
}

#Preview {
  @Previewable @ObservedObject var userSessionModel = UserSessionModel()
  AddPinView(mapModel: MapModel(), userSessionModel: userSessionModel, addPin: .constant(true))
}
