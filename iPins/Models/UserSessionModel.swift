//
//  UserModel.swift
//  iPins
//
//  Created by Saadat Abbas on 12/7/24.
//

import Foundation
import RealmSwift

// Model for User stored in Realm
class User: Object, Identifiable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var username: String
  @Persisted var password: String
  @Persisted var myPins: List<ObjectId>
  @Persisted var savedPins: List<ObjectId>
}


class UserSessionModel: ObservableObject{
  @Published var userSession: User
  @Published var loggedIn: Bool
  @Published var error: String
  @Published var alert: Bool
  let realm: Realm
  
  init(){
    
    self.userSession = User()
    self.loggedIn = false
    self.error = ""
    self.alert = false
    
    do{
      let config = Realm.Configuration(
        schemaVersion: 6, // Increment this version number
        migrationBlock: { migration, oldSchemaVersion in
          if oldSchemaVersion < 6 {
            migration.enumerateObjects(ofType: User.className()) { oldObject, newObject in
              newObject?["newField"] = "defaultValue"
            }
          }
        })
      Realm.Configuration.defaultConfiguration = config
      realm = try Realm()
    } catch{
      fatalError("Error Initializing Realm: \(error)")
    }
  } //end init
  
  //register with username and password
  func register(username: String, password: String, confirmPassword: String){
    guard !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
      self.error = "Please fill in all fields."
      self.alert.toggle()
      return
    }
    
    if password != confirmPassword{
      self.error = "Passwords do not match"
      self.alert.toggle()
      return
    }
    
    // Check if the username already exists
    if let _ = realm.objects(User.self).filter("username == %@", username).first {
      self.error = "Username already exists. Please choose another."
      self.alert.toggle()
      return
    }
    
    // Create a new user
    userSession.username = username
    userSession.password = password
    
    do {
      try realm.write { realm.add(userSession) }
    } catch {
      self.error = "Failed to register user: \(error.localizedDescription)"
      self.alert.toggle()
    }
  } //end func register
  
  // Login with username and password
  func login(username: String, password: String) {
    guard !username.isEmpty, !password.isEmpty else {
      self.error = "Please fill in all fields."
      self.alert.toggle()
      return
    }
    
    // Check if user exists
    if let user = realm.objects(User.self).filter("username == %@", username).first {
      if user.password == password {
        userSession.username = user.username
        userSession.password = user.password
        userSession.myPins = user.myPins
        userSession.savedPins = user.savedPins
        self.loggedIn = true
      } else {
        self.error = "Incorrect password."
        self.alert.toggle()
      }
    } else {
      self.error = "User not found. Please register."
      self.alert.toggle()
    }
  } //end func login
  
  func signOut(){
    //usersession ended
    userSession = User()
    self.loggedIn = false
  } //end func signOut
}
