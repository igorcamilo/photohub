//
//  User.swift
//  PhotoHub
//
//  Created by Igor Camilo on 02/03/17.
//
//

import Marshal

public struct User {
  
  public var id: String
  public var avatarURL: URL
  public var displayName: String
}

extension User: Unmarshaling {
  
  public init(object: MarshaledObject) throws {
    
    id = try object.value(for: "id")
    avatarURL = try object.value(for: "avatar.url")
    displayName = try object.value(for: "displayName")
  }
}
