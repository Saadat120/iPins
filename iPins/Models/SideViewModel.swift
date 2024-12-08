//
//  SideViewModel.swift
//  iPins
//
//  Created by Saadat Abbas on 11/29/24.
//

import Foundation

enum SideViewModel: Int, CaseIterable{
   case home
   case myPins
   case savedEvents
   case events
   
   var title: String{
      switch self {
         case .home:
            return "Home"
         case .myPins:
            return "My Pins"
         case .savedEvents:
            return "Saved Events"
         case .events:
            return "Events"
      }
   }
      
   var systemImageName: String{
      switch self {
         case .home:
            return "house.fill"
         case .myPins:
            return "mappin.and.ellipse"
         case .savedEvents:
            return "heart.fill"
         case .events:
            return "mappin.and.ellipse"
      }
   }
}

extension SideViewModel: Identifiable{
   var id: Int {return self.rawValue}
}
