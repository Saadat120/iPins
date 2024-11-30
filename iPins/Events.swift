//
//  Events.swift
//  iPins
//
//  Created by Saadat Abbas on 11/17/24.
//

import Foundation

struct Pins: Identifiable, Hashable{
   var id: Int?
   let name: String
   let details: String
   let latitude: Double
   let longitude: Double
   let attendees: Int
   let Public: Bool
}

struct Events: Identifiable{
   let id = UUID()
   var eventPins = [Pins]()
}
