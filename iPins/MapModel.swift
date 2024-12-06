//
//  MapModel.swift
//  iPins
//
//  Created by Saadat Abbas on 12/3/24.
//

import SwiftUI
import MapKit

class MapModel: ObservableObject{
  @Published var cameraPosition = MapCameraPosition.region(.region) //camera position
  @Published var bounds = MapCameraBounds(centerCoordinateBounds: .region, minimumDistance: 100, maximumDistance: 100000) //bounds of camera
  @Published var selectedMapItem: MKMapItem? // track user selected map items
  @Published var selectedMapItemTag: Int? // track user selected map items
  @Published var tappedCoordinate: CLLocationCoordinate2D?
}

extension CLLocationCoordinate2D {
  static let newYork: Self = .init(
    latitude: 40.7128,
    longitude: -73.9683
  )
}

extension MKCoordinateRegion{
  static let region: Self = .init(
    center: .newYork,
    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
  
}
