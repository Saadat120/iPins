//
//  iPinsApp.swift
//  iPins
//
//  Created by Saadat Abbas on 11/15/24.
//

import SwiftUI

@main
struct iPinsApp: App {
  @StateObject var mapModel: MapModel = MapModel()
  var body: some Scene {
    WindowGroup {
      let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayouyLogUnsatisfiable")
      let _ = print(
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
      ContentView()
    }
  }
}
