//
//  Pin.swift
//  iPins
//
//  Created by Saadat Abbas on 12/6/24.
//

import Foundation
import RealmSwift


class Pin: Object, Identifiable{
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var name: String
  @Persisted var details: String
  @Persisted var latitude: Double
  @Persisted var longitude: Double
  @Persisted var attendees: Int
  @Persisted var isPublic: Bool
  @Persisted var chats: List<Chat>
  override class func primaryKey() -> String?{
    "id"
  }
}

class Chat: Object, Identifiable{
  @Persisted(primaryKey: true) var user: String
  @Persisted var message: String
}
