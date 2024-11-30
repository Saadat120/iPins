//
//  MapView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/22/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
   static let newYork: Self = .init(
      latitude: 40.7128,
      longitude: -73.9683
      
   )
}

private var boundRegion = MKCoordinateRegion(center: .newYork, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

struct MapView: View {
   @Binding var events: Events
   var cameraPosition: MapCameraPosition { MapCameraPosition.region(boundRegion) }
   var bounds = MapCameraBounds(centerCoordinateBounds: boundRegion, minimumDistance: 100, maximumDistance: 100000)
   
//   @State private var pins = [Pins]()
//   @State private var myPinsArr = myPins(id: 1, pins: [])
//   @State private var savedPins = saved(id: 1, savedPins: [])
//   @State private var eventArr = events(id: 1, eventPins: [])
   @State private var selectedPin: Pins? = nil
   @State private var showPinDetails = false
   
   
   var body: some View {
      Map(position: .constant(cameraPosition), bounds: bounds, interactionModes: .all, scope: nil){
         ForEach(Array(events.eventPins), id: \.self) { item in
            Marker(item.name, coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
         } //end for each
      } //end Map
   } //end body
} //end struct


#Preview {
//   MapView(events: Binding(Events())
}
