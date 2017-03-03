//
//  User.swift
//  PhotoHub
//
//  Created by Igor Camilo on 02/03/17.
//
//

import Marshal

struct User {
  
  var id: String
  var avatarURL: URL
  var displayName: String
}

extension User: Unmarshaling {
  
  init(object: MarshaledObject) throws {
    
    id = try object.value(for: "id")
    avatarURL = try object.value(for: "avatar.url")
    displayName = try object.value(for: "displayName")
  }
}
