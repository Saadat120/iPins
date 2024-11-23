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
      latitude: 40.730610,
      longitude: -73.935242
   )
}

let rect = MKMapRect(
   origin: MKMapPoint(.newYork),
   size: MKMapSize(width: 1, height: 1)
)


struct MapView: View {
   @State private var position: MapCameraPosition = .camera(
      .init(centerCoordinate: .newYork, distance: 0)
   )
    var body: some View {
       Map(position: $position,
           bounds: MapCameraBounds(centerCoordinateBounds: rect, minimumDistance: 100, maximumDistance: 1000)){
          Marker("Central Park", coordinate: .newYork)
       }
    }
}

#Preview {
   MapView()
}
